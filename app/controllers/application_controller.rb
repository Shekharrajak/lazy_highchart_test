# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  def charts
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Combination chart"})
      f.options[:xAxis][:categories] = ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      f.labels(:items=>[:html=>"Total fruit consumption", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
      f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
      f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
      f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67, 3, 6.33, 3.33])
      f.series(:type=> 'pie',:name=> 'Total consumption',
        :data=> [
          {:name=> 'Jane', :y=> 13, :color=> 'red'},
          {:name=> 'John', :y=> 23,:color=> 'green'},
          {:name=> 'Joe', :y=> 19,:color=> 'blue'}
        ],
        :center=> [100, 80], :size=> 100, :showInLegend=> false)
    end

    @chart2 = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
      f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
      f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
      f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

      f.yAxis [
        {:title => {:text => "GDP in Billions", :margin => 70} },
        {:title => {:text => "Population in Millions"}, :opposite => true},
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({:defaultSeriesType=>"column"})
    end

    @chart3 = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
          series = {
                   :type=> 'pie',
                   :name=> 'Browser share',
                   :data=> [
                      ['Firefox',   45.0],
                      ['IE',       26.8],
                      {
                         :name=> 'Chrome',
                         :y=> 12.8,
                         :sliced=> true,
                         :selected=> true
                      },
                      ['Safari',    8.5],
                      ['Opera',     6.2],
                      ['Others',   0.7]
                   ]
          }
          f.series(series)
          f.options[:title][:text] = "THA PIE"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '1000px'})
          f.plot_options(:pie=>{
            :allowPointSelect=>true,
            :cursor=>"pointer" ,
            :dataLabels=>{
              :enabled=>true,
              :color=>"red",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            }
          })
    end

    @chart4 = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'John',:data=> [3, 20, 3, 5, 4, 10, 12 ])
      f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3, 5, 4,-46] )
      f.title({ :text=>"example test title from controller"})
      f.options[:chart][:defaultSeriesType] = "column"
      f.plot_options({:column=>{:stacking=>"percent"}})
    end

    # Clickable bar chart
    @graph1 = LazyHighCharts::HighChart.new('column') do |f|
      f.series(:name=>'Correct',:data=> [1, 2, 3, 4, 5])
      f.series(:name=>'Incorrect',:data=> [10, 2, 3, 1, 4])
      f.title({ :text=>"clickable bar chart"})
      f.legend({:align => 'right',
                :x => -100,
                :verticalAlign=>'top',
                :y=>20,
                :floating=>"true",
                :backgroundColor=>'#FFFFFF',
                :borderColor=>'#CCC',
                :borderWidth=>1,
                :shadow=>"false"
               })
      f.options[:chart][:defaultSeriesType] = "column"
      f.options[:xAxis] = {:plot_bands => "none", :title=>{:text=>"Time"}, :categories => ["1.1.2011", "2.1.2011", "3.1.2011", "4.1.2011", "5.1.2011"]}
      f.options[:yAxis][:title] = {:text=>"Answers"}
      f.plotOptions(series: {
        :cursor => 'pointer',
        :point => {:events => {:click => "click_function"} }
      })
    end


    #  area chart
    @area1 = LazyHighCharts::HighChart.new('my_id8') do |f|
      f.chart( {
          :defaultSeriesType=>"area"
      })
      f.title( {
          :text => 'US and USSR nuclear stockpiles'
      })
      f.subtitle( {
          :text => 'Source: <a href="http://thebulletin.metapress.com/content/c4120650912x74k7/fulltext.pdf">' +
              'thebulletin.metapress.com</a>'
      })
      f.xAxis( {
          :allowDecimals => false,
          :labels => {
          :formatter => function () {
                return this.value; // clean, unformatted number for year
            }
          }
      })
      f.yAxis( {
          :title => {
              :text=> 'Nuclear weapon states'
          },
          :labels => {
          :formatter=> function () {
                return this.value / 1000 + 'k';
            }
      })
      f.tooltip( {
          :pointFormat => '{series.name} produced <b>{point.y:,.0f}</b><br/>warheads in {point.x}'
      })
      f.plotOptions( {
          :area => {
              :pointStart => 1940,
              :marker => {
                  :enabled => false,
                  :symbol => 'circle',
                  :radius => 2,
                  :states => {
                      :hover => {
                          :enabled => true
                      }
                  }
              }
          }
      })
      f.series(
          :name => 'USA',
          :data => [nil, nil, nil, nil, nil, 6, 11, 32, 110, 235, 369, 640,
              1005, 1436, 2063, 3057, 4618, 6444, 9822, 15468, 20434, 24126,
              27387, 29459, 31056, 31982, 32040, 31233, 29224, 27342, 26662,
              26956, 27912, 28999, 28965, 27826, 25579, 25722, 24826, 24605,
              24304, 23464, 23708, 24099, 24357, 24237, 24401, 24344, 23586,
              22380, 21004, 17287, 14747, 13076, 12555, 12144, 11009, 10950,
              10871, 10824, 10577, 10527, 10475, 10421, 10358, 10295, 10104]
      )
      f.series(
          :name => 'USSR/Russia',
          :data => [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil,
              5, 25, 50, 120, 150, 200, 426, 660, 869, 1060, 1605, 2471, 3322,
              4238, 5221, 6129, 7089, 8339, 9399, 10538, 11643, 13092, 14478,
              15915, 17385, 19055, 21205, 23044, 25393, 27935, 30062, 32049,
              33952, 35804, 37431, 39197, 45000, 43000, 41000, 39000, 37000,
              35000, 33000, 31000, 29000, 27000, 25000, 24000, 23000, 22000,
              21000, 20000, 19000, 18000, 18000, 17000, 16000]
      )
    end


    @funnel_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(type: "funnel", marginRight: 100)
      f.title({ text: 'Sales funnel', x: -50})
      f.plotOptions( series: {
                      dataLabels: {
                          enabled: true,
                          format: '<b>{point.name}</b> ({point.y:,.0f})',
                          color: 'black',
                          softConnector: true},
                      neckWidth: '30%',
                      neckHeight: '25%'
                    })
      f.legend( { enabled: false })
      f.series( name: 'Unique users',
                data: [
                      ['Website visits',   15654],
                      ['Website visits bounces', 6954],
                      #['Downloads',       4064],
                      ['View contact info', 1987],
                      ['Requested info', 987]
                    ]
              )
    end

    @chart3d_1 = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170], options3d: {
            enabled: true,
            alpha: 15,
            beta: 15,
            depth: 50,
            viewDistance: 25}} )
          series = {
                   :type=> 'pie',
                   :name=> 'Browser share',
                   :data=> [
                      ['Firefox',   45.0],
                      ['IE',       26.8],
                      {
                         :name=> 'Chrome',
                         :y=> 12.8,
                         :sliced=> true,
                         :selected=> true
                      },
                      ['Safari',    8.5],
                      ['Opera',     6.2],
                      ['Others',   0.7]
                   ]
          }
          f.series(series)
          f.options[:title][:text] = "THA PIE"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
          f.plot_options(:pie=>{
            :allowPointSelect=>true,
            :cursor=>"pointer" ,
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            },
            depth: 25

          })
    end


    @chart3d_2 = LazyHighCharts::HighChart.new('column') do |f|
          f.chart({:defaultSeriesType=>"column" , :margin=> 75, options3d: {
            enabled: true,
            alpha: 15,
            beta: 15,
            depth: 50,
            viewDistance: 25}} )
          series = {
                   :type=> 'column',
                   :name=> 'Browser share',
                   :data=> [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
          }
          f.series(series)
          f.options[:title][:text] = "THA PIE"
          f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'})
          f.plot_options(:column=>{
            :allowPointSelect=>true,
            :cursor=>"pointer" ,
            :dataLabels=>{
              :enabled=>true,
              :color=>"black",
              :style=>{
                :font=>"13px Trebuchet MS, Verdana, sans-serif"
              }
            },
            depth: 25

          })
    end

    @line1 = LazyHighCharts::HighChart.new('line') do |f|
      f.chart({:defaultSeriesType=>"line" } )
      f.title( {
        :text=> 'Monthly Average Temperature'
      })
      f.subtitle( {
          :text=> 'Source: WorldClimate.com'
      })
      f.xAxis( {
          :categories => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      })
      f.yAxis( {
          :title=> {
              :text=> 'Temperature (°C)'
          }
      })
      f.plotOptions({
          :line=> {
              :dataLabels=> {
                  :enabled=> true
              },
              :enableMouseTracking=> false
          }
      })
      f.series( {
          :name=> 'Tokyo',
          :data=> [7.0, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
      })
      f.series({
          :name=> 'London',
          :data=> [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
      })
    end

    render "charts" , layout: "application"
  end
end
