﻿app.requires.push('commonMethods');

app.controller('skfCtrl', function ($scope, languageFactory, $http) {
    $scope.firstTab = true;
    $scope.secondTab = false;
    $scope.thirdTab = false;

    $scope.sortby = function () {
        $scope.sordByDDL = [
            { 'val': 20, 'text': '20 Records' },
            { 'val': 50, 'text': '50 Records' },
            { 'val': 100, 'text': '100 Records' },
            { 'val': 250, 'text': '250 Records' }
        ];
    }();

    $scope.ShowTab = function (data) {
        switch (data) {
            case 'first':
                $scope.firstTab = true;
                $scope.secondTab = false;
                $scope.thirdTab = false;
                $scope.loadData();
                break;
            case 'second':
                $scope.firstTab = false;
                $scope.secondTab = true;
                $scope.thirdTab = false;
                $scope.loadData();
                $scope.loadsecond();
                break;
            case 'third':
                $scope.firstTab = false;
                $scope.secondTab = false;
                $scope.thirdTab = true;
                break;
        }
    }

    $scope.chartfirst = function (data) {
        //First Chart
        Highcharts.chart('container', {
            chart: {
                type: 'funnel'
            },
            title: {
                text: 'Sales funnel'
            },
            plotOptions: {
                series: {
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b> ({point.y:,.0f})',
                        softConnector: true
                    },
                    center: ['40%', '50%'],
                    neckWidth: '30%',
                    neckHeight: '25%',
                    width: '80%'
                }
            },
            legend: {
                enabled: false
            },
            series: [{
                name: 'Unique users',
                data: data
            }],

            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        plotOptions: {
                            series: {
                                dataLabels: {
                                    inside: true
                                },
                                center: ['50%', '50%'],
                                width: '100%'
                            }
                        }
                    }
                }]
            }
        });
    }

    $scope.chartsecond = function (data) {
        //Second Chart
        Highcharts.chart('container1', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {

                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: data
            }]
        });

        Highcharts.chart('container2', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: $scope.Chart3
            }]
        });

        Highcharts.chart('container4', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            //tooltip: {
            //    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            //},
            plotOptions: {
                pie: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: $scope.Chart4
            }]
        });

        Highcharts.chart('container3', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: $scope.Chart5
            }]
        });
    };

    $scope.chartthird = function (data) {
        Highcharts.chart('container2', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: data
            }]
        });
    };

    $scope.chartfourth = function (data) {
        Highcharts.chart('container3', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: data
            }]
        });

    }

    $scope.chartfifth = function (data) {
        Highcharts.chart('container4', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Browser market shares in January, 2018'
            },
            //tooltip: {
            //    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            //},
            plotOptions: {
                pie: {
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: data
            }]
        });
    }

    $scope.loadData = function () {
        $scope.LoadDataList = [];
        var _postdata = {
            "UserId": 1,
            "LanguageId": $scope.language.LanguageId,
            "CountryId": [{ CountryId: 1 }],
            "CostCentreId": [],
            "SectorId": [],
            "SegmentId": [],
            "ClientSiteId": [],
            "IndustryId": [],
            "PlantAreaId": []
        };
        var postUrl = "/Dashboard/GetFailureCauseDetail";
        $http.post(postUrl, JSON.stringify(_postdata)).then(function (response) {
            $scope.LoadDataList = JSON.parse(response.data[0].ChartPoints);
            $scope.loadChartData($scope.LoadDataList, 20);
        });
    };

    $scope.loadChartData = function (data, val) {
        $scope.Chart1 = [];
        $scope.Chart2 = [];
        $scope.Chart3 = [];
        $scope.Chart4 = [];
        $scope.Chart5 = [];
        //data.filter(function (el) {
        //    $scope.Chart1.push({ "name": el.FailureCause, "y": el.Consequence });
        //    $scope.Chart2.push({ "name": el.FailureCause, "y": el.Events });
        //    $scope.Chart3.push({ "name": el.FailureCause, "y": el.DriveEnvents });
        //    $scope.Chart4.push({ "name": el.FailureCause, "y": el.IntermediateEvents });
        //    $scope.Chart5.push({ "name": el.FailureCause, "y": el.DrivenEnvents });
        //});
        if (val) {
            if (val === 1000) {
                var j = data.length;
            } else {
                j = val;
            }

        }
        for (i = 0; i < j; i++) {
            $scope.Chart1.push({ "name": data[i].FailureCause, "y": data[i].Consequence });
            $scope.Chart2.push({ "name": data[i].FailureCause, "y": data[i].Events });
            $scope.Chart3.push({ "name": data[i].FailureCause, "y": data[i].DriveEnvents });
            $scope.Chart4.push({ "name": data[i].FailureCause, "y": data[i].IntermediateEvents });
            $scope.Chart5.push({ "name": data[i].FailureCause, "y": data[i].DrivenEnvents });
        }

        return $scope.loadc();
    };

    $scope.loadc = function () {
        console.log($scope.Chart1);
        console.log($scope.Chart2);
        console.log($scope.Chart3);
        console.log($scope.Chart4);
        console.log($scope.Chart5);
        $scope.chartfirst($scope.Chart1);
        $scope.chartsecond($scope.Chart2);
        //$scope.chartthird($scope.Chart3);
        //$scope.chartfourth($scope.Chart4);
        //$scope.chartfifth($scope.Chart5);
    };

    $scope.loadDropDown = function () {
        $scope.dropDownData = [];
        var _url = "/Bearing/GetBearingBybyCount?lid=" + $scope.language.LanguageId;
        $http.get(_url)
            .then(function (response) {
                $scope.dropDownData = response.data;
                return $scope.pushed($scope.dropDownData);
            });
    };

    $scope.pushed = function (data) {
        $scope.countryDDL = [];
        $scope.costcentreDDL = [];
        $scope.clientSiteDDL = [];
        $scope.sectorDDL = [];
        $scope.segmentDDL = [];
        $scope.industryDDL = [];
        data.filter(function (el) {
            $scope.countryDDL.push({ "CountryId": el.CountryId, "CountryName": el.CountryName });
            $scope.costcentreDDL.push({ "CostCentreId": el.CostCentreId, "CostCentreName": el.CostCentreName });
            $scope.clientSiteDDL.push({ "ClientSiteId": el.ClientSiteId, "ClientSiteName": el.ClientSiteName });
            $scope.sectorDDL.push({ "SectorId": el.SectorId, "SectorName": el.SectorName });
            $scope.segmentDDL.push({ "SegmentId": el.SegmentId, "SegmentName": el.SegmentName });
            $scope.industryDDL.push({ "IndustryId": el.IndustryId, "IndustryName": el.IndustryName });
        });
        return $scope.loadData();
    };

    $scope.$watch(function () {
        return languageFactory.getLanguage();
    }, function (newValue, oldValue) {
        if (newValue !== oldValue && newValue) {
            $scope.language = newValue;
            $scope.loadDropDown();
        }
    });

    $scope.loadsecond = function () {
        Highcharts.chart('container5', {
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Historic World Population by Region'
            },
            subtitle: {
                text: 'Source: <a href="https://en.wikipedia.org/wiki/World_population">Wikipedia.org</a>'
            },
            xAxis: {
                categories: ['Africa', 'America', 'Asia', 'Europe', 'Oceania'],
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Population (millions)',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: ' millions'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -40,
                y: 80,
                floating: true,
                borderWidth: 1,
                backgroundColor:
                    Highcharts.defaultOptions.legend.backgroundColor || '#FFFFFF',
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Year 1800',
                data: [107, 31, 635, 203, 2]
            }, {
                name: 'Year 1900',
                data: [133, 156, 947, 408, 6]
            }, {
                name: 'Year 2000',
                data: [814, 841, 3714, 727, 31]
            }, {
                name: 'Year 2016',
                data: [1216, 1001, 4436, 738, 40]
            }]
        });
        Highcharts.chart('container6', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Stacked column chart'
            },
            xAxis: {
                categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total fruit consumption'
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        fontWeight: 'bold',
                        color: ( // theme
                            Highcharts.defaultOptions.title.style &&
                            Highcharts.defaultOptions.title.style.color
                        ) || 'gray'
                    }
                }
            },
            legend: {
                align: 'right',
                x: -30,
                verticalAlign: 'top',
                y: 25,
                floating: true,
                backgroundColor:
                    Highcharts.defaultOptions.legend.backgroundColor || 'white',
                borderColor: '#CCC',
                borderWidth: 1,
                shadow: false
            },
            tooltip: {
                headerFormat: '<b>{point.x}</b><br/>',
                pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            series: [{
                name: 'John',
                data: [5, 3, 4, 7, 2]
            }, {
                name: 'Jane',
                data: [2, 2, 3, 2, 1]
            }, {
                name: 'Joe',
                data: [3, 4, 4, 2, 5]
            }]
        });

        Highcharts.chart('container7', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'World\'s largest cities per 2017'
            },
            subtitle: {
                text: 'Source: <a href="http://en.wikipedia.org/wiki/List_of_cities_proper_by_population">Wikipedia</a>'
            },
            xAxis: {
                type: 'category',
                labels: {
                    rotation: -45,
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Population (millions)'
                }
            },
            legend: {
                enabled: false
            },
            tooltip: {
                pointFormat: 'Population in 2017: <b>{point.y:.1f} millions</b>'
            },
            series: [{
                name: 'Population',
                data: [
                    ['Shanghai', 24.2],
                    ['Beijing', 20.8],
                    ['Karachi', 14.9],
                    ['Shenzhen', 13.7],
                    ['Guangzhou', 13.1],
                    ['Istanbul', 12.7],
                    ['Mumbai', 12.4],
                    ['Moscow', 12.2],
                    ['São Paulo', 12.0],
                    ['Delhi', 11.7],
                    ['Kinshasa', 11.5],
                    ['Tianjin', 11.2],
                    ['Lahore', 11.1],
                    ['Jakarta', 10.6],
                    ['Dongguan', 10.6],
                    ['Lagos', 10.6],
                    ['Bengaluru', 10.3],
                    ['Seoul', 9.8],
                    ['Foshan', 9.3],
                    ['Tokyo', 9.3]
                ],
                dataLabels: {
                    enabled: true,
                    rotation: -90,
                    color: '#FFFFFF',
                    align: 'right',
                    format: '{point.y:.1f}', // one decimal
                    y: 10, // 10 pixels down from the top
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            }]
        });

        Highcharts.chart('container8', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: 0,
                plotShadow: false
            },
            title: {
                text: 'Browser<br>shares<br>2017',
                align: 'center',
                verticalAlign: 'middle',
                y: 40
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    dataLabels: {
                        enabled: true,
                        distance: -50,
                        style: {
                            fontWeight: 'bold',
                            color: 'white'
                        }
                    },
                    startAngle: -90,
                    endAngle: 90,
                    center: ['50%', '75%'],
                    size: '110%'
                }
            },
            series: [{
                type: 'pie',
                name: 'Browser share',
                innerSize: '50%',
                data: [
                    ['Chrome', 58.9],
                    ['Firefox', 13.29],
                    ['Internet Explorer', 13],
                    ['Edge', 3.78],
                    ['Safari', 3.42],
                    {
                        name: 'Other',
                        y: 7.61,
                        dataLabels: {
                            enabled: false
                        }
                    }
                ]
            }]
        });
    }
});
