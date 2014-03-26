require 'factory_girl_rails'

namespace :db do
  namespace :test do
    task :prepare => :environment do
      # categories
      categories = ['Access', 'Control', 'Activity'].map{|n| Category.find_or_create_by_name(n)}
       
      # categories
      grp_adoption = Group.create! admin_name: 'adoption', public_name: 'Adoption'
      grp_speed = Group.create! admin_name: 'speed', public_name: 'Speed and Quality'
      grp_price = Group.create! admin_name: 'price', public_name: 'Price'
      grp_human = Group.create! admin_name: 'human', public_name: 'Literacy and Gender Equality'

      # language
      persian = FactoryGirl.create( :persian );
      persian.save!

      english = FactoryGirl.create( :english );
      english.save!

      chinese = FactoryGirl.create( :chinese );
      chinese.save!

      # countries
      iran = FactoryGirl.create( :iran );
      iran.categories = categories;
      iran.languages << persian;
      iran.save!

      china = FactoryGirl.create( :china );
      china.categories = categories;
      china.languages << chinese;
      china.save!

      usa = FactoryGirl.create( :usa );
      usa.categories = categories;
      usa.languages << english;
      usa.save!

      country_nil_score = FactoryGirl.create( :country_nil_score );
      country_nil_score.categories = categories;
      country_nil_score.languages << english;
      country_nil_score.save!

      # access datum sources
      ds_pct_inet = FactoryGirl.create :ds_pct_inet
      ds_pct_inet.category = categories[ 0 ]
      ds_pct_inet.group = grp_adoption
      ds_pct_inet.save!

      ds_fixed_monthly = FactoryGirl.create :ds_fixed_monthly
      ds_fixed_monthly.category = categories[ 0 ]
      ds_fixed_monthly.group = grp_price
      ds_fixed_monthly.save!

      ds_fixed_monthly_gdp = FactoryGirl.create :ds_fixed_monthly_gdp
      ds_fixed_monthly_gdp.category = categories[ 0 ]
      ds_fixed_monthly_gdp.group = grp_price
      ds_fixed_monthly_gdp.save!

      ds_lit_rate = FactoryGirl.create :ds_lit_rate
      ds_lit_rate.category = categories[ 0 ]
      ds_lit_rate.group = grp_human
      ds_lit_rate.save!

      # access datum
      d_pct_inet_iran = FactoryGirl.create( :d_pct_inet_iran );
      d_pct_inet_iran.source = ds_pct_inet;
      d_pct_inet_iran.country = iran;
      d_pct_inet_iran.save!

      d_fixed_monthly_iran = FactoryGirl.create( :d_fixed_monthly_iran );
      d_fixed_monthly_iran.source = ds_fixed_monthly;
      d_fixed_monthly_iran.country = iran;
      d_fixed_monthly_iran.save!

      d_fixed_monthly_gdp_iran = FactoryGirl.create( :d_fixed_monthly_gdp_iran );
      d_fixed_monthly_gdp_iran.source = ds_fixed_monthly_gdp;
      d_fixed_monthly_gdp_iran.country = iran;
      d_fixed_monthly_gdp_iran.save!

      d_lit_rate_iran = FactoryGirl.create( :d_lit_rate_iran );
      d_lit_rate_iran.source = ds_lit_rate;
      d_lit_rate_iran.country = iran;
      d_lit_rate_iran.save!

      d_pct_inet_china = FactoryGirl.create( :d_pct_inet_china );
      d_pct_inet_china.source = ds_pct_inet;
      d_pct_inet_china.country = china;
      d_pct_inet_china.save!

      d_fixed_monthly_china = FactoryGirl.create( :d_fixed_monthly_china );
      d_fixed_monthly_china.source = ds_fixed_monthly;
      d_fixed_monthly_china.country = china;
      d_fixed_monthly_china.save!

      d_fixed_monthly_gdp_china = FactoryGirl.create( :d_fixed_monthly_gdp_china );
      d_fixed_monthly_gdp_china.source = ds_fixed_monthly_gdp;
      d_fixed_monthly_gdp_china.country = china;
      d_fixed_monthly_gdp_china.save!

      d_lit_rate_china = FactoryGirl.create( :d_lit_rate_china );
      d_lit_rate_china.source = ds_lit_rate;
      d_lit_rate_china.country = china;
      d_lit_rate_china.save!

      d_pct_inet_usa = FactoryGirl.create( :d_pct_inet_usa );
      d_pct_inet_usa.source = ds_pct_inet;
      d_pct_inet_usa.country = usa;
      d_pct_inet_usa.save!

      # control datum sources
      ds_consistency = FactoryGirl.create :ds_consistency
      ds_consistency.category = categories[ 1 ]
      ds_consistency.save!

      ds_herdict_quickstats = FactoryGirl.create :ds_herdict_quickstats
      ds_herdict_quickstats.category = categories[ 1 ]
      ds_herdict_quickstats.save!

      ds_herdict = FactoryGirl.create :ds_herdict
      ds_herdict.category = categories[ 1 ]
      ds_herdict.save!

      # control datum
      d_consistency_iran = FactoryGirl.create( :d_consistency_iran );
      d_consistency_iran.source = ds_consistency;
      d_consistency_iran.country = iran;
      d_consistency_iran.save!

      d_consistency_china = FactoryGirl.create( :d_consistency_china );
      d_consistency_china.source = ds_consistency;
      d_consistency_china.country = china;
      d_consistency_china.save!

      d_herdict_quickstats_iran = FactoryGirl.create :d_herdict_quickstats_iran
      d_herdict_quickstats_iran.source = ds_herdict_quickstats
      d_herdict_quickstats_iran.country = iran
      d_herdict_quickstats_iran.save!

      d_herdict_iran = FactoryGirl.create :d_herdict_iran
      d_herdict_iran.source = ds_herdict
      d_herdict_iran.country = iran
      d_herdict_iran.value = IO.read 'db/test_data/herd_irn.html'
      d_herdict_iran.save!

      # activity datum sources
      ds_morningside = FactoryGirl.create :ds_morningside
      ds_morningside.category = categories[ 2 ]
      ds_morningside.save!

      # access datum
      d_morningside = FactoryGirl.create :d_morningside
      d_morningside.source = ds_morningside
      d_morningside.language = persian
      d_morningside.value = IO.read 'db/test_data/morningside.json'
      d_morningside.save

      # other datum source
      ds_population = FactoryGirl.create( :ds_population );
      ds_population.save

      ds_gdp = FactoryGirl.create( :ds_gdp );
      ds_gdp.save

      # other datum
      d_population_iran = FactoryGirl.create( :d_population_iran )
      d_population_iran.source = ds_population
      d_population_iran.country = iran
      d_population_iran.save

      d_gdp_iran = FactoryGirl.create( :d_gdp_iran )
      d_gdp_iran.source = ds_gdp
      d_gdp_iran.country = iran
      d_gdp_iran.save

      d_population_china = FactoryGirl.create( :d_population_china );
      d_population_china.source = ds_population;
      d_population_china.country = china;
      d_population_china.save!

      # count all valid indicators
      Country.count_indicators!

      # recalc indicator min_max & values
      DatumSource.recalc_min_max_and_values!

      # calculate all scores
      Country.calculate_scores_and_rank!

      # refinery
      Refinery::Pages::Engine.load_seed
      Refinery::Blog::Engine.load_seed

      u = FactoryGirl.create( :tadmin )
      u.create_first

      # Home page
      home_page = Refinery::Page.by_slug( 'home' ).first
      home_page_access = FactoryGirl.create :home_page_access
      home_page_access.page = home_page
      home_page_access.save

      # Carousel page
      carousel_page = FactoryGirl.create :carousel_page

      carousel_about_page = FactoryGirl.create :carousel_about_page
      carousel_about_page.parent = carousel_page
      carousel_about_page.save

      carousel_about_page_body = FactoryGirl.create :carousel_about_page_body
      carousel_about_page_body.page = carousel_about_page
      carousel_about_page_body.save

      carousel_map_page = FactoryGirl.create :carousel_map_page
      carousel_map_page.parent = carousel_page
      carousel_map_page.save

      carousel_map_page_body = FactoryGirl.create :carousel_map_page_body
      carousel_map_page_body.page = carousel_map_page
      carousel_map_page_body.save

      # Trending page
      trending_page = FactoryGirl.create :trending_page

      trending_page_body = FactoryGirl.create :trending_page_body
      trending_page_body.page = trending_page
      trending_page_body.save

      # Data page
      sources_page = FactoryGirl.create :sources_page

      sources_page_body = FactoryGirl.create :sources_page_body
      sources_page_body.page = sources_page
      sources_page_body.save

      sources_page_side_body = FactoryGirl.create :sources_page_side_body
      sources_page_side_body.page = sources_page
      sources_page_side_body.save

      ## mock custom slug/title
      sources_page_translation = sources_page.translation
      sources_page_translation.title = 'Data'
      sources_page_translation.custom_slug = 'sources'
      sources_page_translation.save

      # IRN page
      iran_page = FactoryGirl.create :iran_page
      iran_page_body = FactoryGirl.create :iran_page_body
      iran_page_body.page = iran_page
      iran_page_body.save
      iran_page_access = FactoryGirl.create :iran_page_access
      iran_page_access.page = iran_page
      iran_page_access.save
      iran_page_control = FactoryGirl.create :iran_page_control
      iran_page_control.page = iran_page
      iran_page_control.save
      iran_page_activity = FactoryGirl.create :iran_page_activity
      iran_page_activity.page = iran_page
      iran_page_activity.save

      # Data page
      ds_morningside_1_page = FactoryGirl.create :ds_morningside_1_page

      ds_morningside_1_page_body = FactoryGirl.create :ds_morningside_1_page_body
      ds_morningside_1_page_body.page = ds_morningside_1_page
      ds_morningside_1_page_body.save

      ds_morningside_1_page_side_body = FactoryGirl.create :ds_morningside_1_page_side_body
      ds_morningside_1_page_side_body.page = ds_morningside_1_page
      ds_morningside_1_page_side_body.save

      # Blog
      blog_post = FactoryGirl.create :blog_post
      blog_post.user_id = u.id
      blog_post.save
    end
  end
end

