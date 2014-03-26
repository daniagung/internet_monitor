class DatumSource < ActiveRecord::Base
    attr_accessible :admin_name, :default_weight, :description, :in_category_page, :in_sidebar, :requires_page, :is_api, :source_name, :source_link, :max, :min, :public_name, :retriever_class, :datum_type, :affects_score, :display_prefix, :display_suffix, :precision

    belongs_to :category
    belongs_to :group

    has_many :data, :autosave => true
    has_one :ingester
    delegate :ingest_data!, :to => :ingester

    def self.recalc_min_max_and_values!
      all.each { |ds|
        if ds.datum_type == 'Indicator'
          ds.recalc_min_max
          ds.save!
          ds.recalc_all_values
        end
      }
    end

    def retriever_class
        read_attribute(:retriever_class).constantize.new
    end

    def retreiver_class=(klass)
        write_attribute(:retriever_class, klass.name)
    end

    def recalc_min_max
        # I should use duck-typing here
        return unless datum_type == 'Indicator'
        country_ids = Country.with_enough_data.map { |c| c.id }
        most_recent = data.most_recent.where( { country_id: country_ids } )
        temp_data = most_recent.map{|d| d.original_value } 
        self.min, self.max = temp_data.min, temp_data.max
    end

    def recalc_all_values
        # I should use duck-typing here
        return unless datum_type == 'Indicator' && min.present? && max.present?
        data.each { |datum|
          datum.calc_percent
          datum.save
        }
    end

    def ingest_data!(options = {})
        self.data = retriever_class.data(options)
        save!
        unless data.empty?
            self.datum_type = data.first.type
            logger.info %Q|Ingested #{data.count} data from "#{public_name}"|
            save!
        end
    end
end
