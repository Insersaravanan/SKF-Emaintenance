﻿app.requires.push('commonMethods', 'ngTouch', 'ui.grid', 'ui.grid.selection', 'ui.grid.resizeColumns', 'ui.grid.edit', 'ui.grid.cellNav', 'ui.grid.pinning', 'ui.grid.exporter');
var app = angular.module('myApp', []);
app.controller("mainController", function ($scope, $http) {
    $scope.results = [];
    $scope.filterText = null;
    $scope.availableCategories = [];
    $scope.availableSpecies = [];
    $scope.categoryFilter = null;

    $scope.init = function () {
        // Download the spreadsheet data and add it to the scope objects above
        $http.jsonp('http://spreadsheets.google.com/feeds/list/1RF7iCiu9VdMyE0MB_cQH8QTnqV-3yFiR_lPyUNcvw5s/od6/public/values?alt=json-in-script' + '&callback=JSON_CALLBACK').success(function (data) {

            angular.forEach(data, function (value, index) {
                angular.forEach(value.entry, function (classes, index) {
                    $scope.results.push(classes);
                    angular.forEach(classes.gsx$personality, function (category, index) {
                        var exists = false;
                        angular.forEach($scope.availableCategories, function (avCat, index) {
                            if (avCat == category) {
                                exists = true;
                            }
                        });
                        if (exists === false) {
                            $scope.availableCategories.push(category);
                        }
                    });
                    angular.forEach(classes.gsx$species, function (species, index) {
                        var exists = false;
                        angular.forEach($scope.availableSpecies, function (avSpec, index) {
                            if (avSpec == species) {
                                exists = true;
                            }
                        });
                        if (exists === false) {
                            $scope.availableSpecies.push(species);
                        }
                    });
                });
            });
        }).error(function (error) {

        });
    };

    $scope.setCategoryFilter = function (category) {
        $scope.categoryFilter = category;
    };

});






app.controller('skfCtrl', function ($scope, $filter, uiGridConstants, $http, $uibModal,$translate,$rootScope, $window, languageFactory, alertFactory, clientFactory, $timeout) {
    $scope.startIndex = 1;
    $scope.readOnlyPage = false;
    $scope.formatters = {};
    $scope.language = null;
    $scope.Active = "All";

    var _columns = [
        {
            name: 'sno', displayName: '#', width: "4%", minWidth: 50, cellClass: getCellClass, enableFiltering: false, enableSorting: false,
            cellTemplate: '<div class="ui-grid-cell-contents">{{grid.renderContainers.body.visibleRowCache.indexOf(row) + 1}}</div>'
        },
        {
            name: 'PlantAreaName', displayName: 'Plant Name', headerCellFilter: 'translate', cellClass: getCellClass, enableColumnResizing: true, width: "20%", minWidth: 150, aggregationHideLabel: false, aggregationType: uiGridConstants.aggregationTypes.count,
            footerCellTemplate: '<div class="ui-grid-cell-contents" >{{"Total Count"|translate}}: {{col.getAggregationValue() | number:0 }}</div>'
        },
        { name: 'AreaName', displayName: 'Area Name', headerCellFilter: 'translate', cellClass: getCellClass, enableColumnResizing: true, width: "20%", minWidth: 150 },
        { name: 'Descriptions', displayName: 'Descriptions', headerCellFilter: 'translate', cellClass: getCellClass, enableColumnResizing: true, width: "25%", minWidth: 100 },
        {
            name: 'Active', displayName: 'Status', headerCellFilter: 'translate', cellClass: getCellClass,
            cellTemplate: '<div class="status"> {{ row.entity.Active == "Y" ? "&nbsp;Active" : "&nbsp;Inactive" }}</div>',
            //cellClass: function (grid, row, col, rowRenderIndex, colRenderIndex) {
            //    if (grid.getCellValue(row, col) === "Y") {
            //        return 'green';
            //    } else {
            //        if (grid.getCellValue(row, col) === "N") {
            //            return 'red';
            //        }
            //    }
            //},

            filter: {
                type: uiGridConstants.filter.SELECT,
                selectOptions: [{ value: 'Y', label: 'Active' }, { value: 'N', label: 'Inactive' }],
            },
            width: "16%",
            minWidth: 100
        },
        {
            name: 'Action', displayName: 'Action', headerCellFilter: 'translate', enableFiltering: false, enableSorting: false, cellClass: getCellClass,
            cellTemplate: '<div class="ui-grid-cell-contents">' +
                '<a ng-click="grid.appScope.editRow(row.entity)" <i class="fa fa-pencil-square-o icon-space-before" tooltip-append-to-body="true" uib-tooltip={{"EditArea"|translate}} tooltip-class="customClass"></i></a>' +
                '<a ng-click="grid.appScope.multiLanguage(row.entity)" <i class="fa fa-language icon-space-before" tooltip-append-to-body="true" uib-tooltip={{"MultiLanguage"|translate}} tooltip-class="customClass"></i></a>' +
                //'<a ng-click="grid.appScope.clone(row,\'AR\')"><i class="fa fa-clone icon-space-before" tooltip-append-to-body="true" uib-tooltip="Clone Unit" tooltip-class="customClass"></i></a>' +
                '</div>',
            width: "15%",
            minWidth: 100
        }
    ];

    $scope.editRow = function (row) {
        $scope.isEdit = true;
        $scope.clearModal();
        $scope.Area = row;
        $scope.isCreate = false;
        $scope.isSearch = false;
    };

    $scope.resetForm = function () {
        setTimeout(function () {
            var elements = document.getElementsByName("userForm")[0].querySelectorAll(".has-error");
            for (var i = 0; i < elements.length; i++) {
                elements[i].className = elements[i].className.replace(/\has-error\b/g, "");
            }
        }, 500);
    };

    $scope.clearModal = function () {
        $scope.readOnlyPage = false;
        $scope.isProcess = false;
        $scope.Area = {
            LanguageId: $scope.language.LanguageId,
            PlantAreaId: null,
            AreaName: null,
            Descriptions: null,
            Active: null


        };
        $scope.resetForm();
    };

    $scope.clearOut = function () {
        $scope.clearModal();
    };

    //$scope.clearValue = function () {
    //    $scope.S_Plant = {
    //        Status: 'All'
    //    }
    //};
    //$scope.clearValue();

    $scope.createToggle = function () {
        $scope.isCreate = true;
        $scope.isEdit = false;
        $scope.clearModal();
    };

    $scope.columns = angular.copy(_columns);

    function getCellClass(grid, row) {
        return row.uid === highlightRow ? 'highlight' : '';
    }

    var highlightRow = null;


    //Set grid options to grid
    $scope.gridOpts = {
        columnDefs: $scope.columns,
        enableFiltering: true,
        enablePinning: true,
        enableColumnResizing: true,
        showColumnFooter: true,
        enableRowSelection: true,
        enableSorting: true,
        onRegisterApi: function (gridApi) {
            $scope.gridApi = gridApi;
            $scope.gridApi.core.refresh();
            var col = $scope.columns;
            $scope.gridApi.grid.clearAllFilters = function () {
                $scope.gridOpts.columnDefs = [];
                $timeout(function () {
                    $scope.gridOpts.columnDefs = angular.copy(_columns);
                }, 2);
            };
            gridApi.cellNav.on.navigate($scope, function (selected) {

                if ('.ui-grid-cell-focus') {
                    highlightRow = selected.row.uid;
                    gridApi.core.notifyDataChange(uiGridConstants.dataChange.COLUMN);
                }

            });
        },
        enableGridMenu: true,
        enableSelectAll: false,
        exporterMenuPdf: false,
        exporterMenuCsv: false,
        exporterExcelFilename: 'EMaintenance_Segment.xlsx',
        exporterExcelSheetName: 'EMaintenance_Segment',
        exporterExcelCustomFormatters: function (grid, workbook, docDefinition) {

            var stylesheet = workbook.getStyleSheet();
            var stdStyle = stylesheet.createFontStyle({
                size: 9, fontName: 'Calibri'
            });
            var boldStyle = stylesheet.createFontStyle({
                size: 9, fontName: 'Calibri', bold: true
            });
            var aFormatDefn = {
                "font": boldStyle.id,
                "alignment": { "wrapText": true }
            };
            var formatter = stylesheet.createFormat(aFormatDefn);
            // save the formatter
            $scope.formatters['bold'] = formatter;
            var dateFormatter = stylesheet.createSimpleFormatter('date');
            $scope.formatters['date'] = dateFormatter;

            aFormatDefn = {
                "font": stdStyle.id,
                "fill": { "type": "pattern", "patternType": "solid", "fgColor": "FFFFC7CE" },
                "alignment": { "wrapText": true }
            };
            var singleDefn = {
                font: stdStyle.id,
                format: '#,##0.0'
            };
            formatter = stylesheet.createFormat(aFormatDefn);
            // save the formatter
            $scope.formatters['red'] = formatter;

            Object.assign(docDefinition.styles, $scope.formatters);

            return docDefinition;
        },
        exporterExcelHeader: function (grid, workbook, sheet, docDefinition) {
            // this can be defined outside this method
            var stylesheet = workbook.getStyleSheet();
            var aFormatDefn = {
                "font": { "size": 11, "fontName": "Calibri", "bold": true },
                "alignment": { "wrapText": true }
            };
            var formatterId = stylesheet.createFormat(aFormatDefn);

            // excel cells start with A1 which is upper left corner
            sheet.mergeCells('B1', 'C1');
            var cols = [];
            // push empty data
            cols.push({ value: '' });
            // push data in B1 cell with metadata formatter
            cols.push({ value: 'SKF', metadata: { style: formatterId.id } });
            sheet.data.push(cols);
        },
        exporterFieldFormatCallback: function (grid, row, gridCol, cellValue) {
            // set metadata on export data to set format id. See exportExcelHeader config above for example of creating
            // a formatter and obtaining the id
            var formatterId = null;
            if (gridCol.field === 'name' && cellValue && cellValue.startsWith('W')) {
                formatterId = $scope.formatters['red'].id;
            }

            if (gridCol.field === 'updatedDate') {
                formatterId = $scope.formatters['date'].id;
            }

            if (formatterId) {
                return { metadata: { style: formatterId } };
            } else {
                return null;
            }
        },
        exporterColumnScaleFactor: 4.5,
        exporterFieldApplyFilters: true
    };


    $scope.loadData = function () {

        // $scope.gridOpts.data = [];
        //$scope.isPageLoad = true;
        var _url = "/Area/GetAreaByStatus?csId=" + $scope.ClientSiteId + "&lId=" + $scope.language.LanguageId;
        $http.get(_url)
            .then(function (response) {
                $scope.gridOpts.data = response.data;
                angular.forEach($scope.gridOpts.data, function (val, i) {
                    val.sno = i + 1;
                });

            });

    };



    $scope.selectClient = function () {
        var clientInfo = sessionStorage.getItem("clientInfo");
        clientFactory.setClient(clientInfo);

        if (clientInfo == null) {
            //var modalInstance = $uibModal.open({
            //    templateUrl: 'skfClientInfoModal.html',
            //    controller: 'skfClientInfoModalCtrl',
            //    size: 'md',
            //    backdrop: 'static',
            //    keyboard: false,
            //    resolve: {
            //        params: function () {
            //            return { "languageId": $scope.language.LanguageId, "ClientName": $scope.clientName };
            //        }
            //    }
            //});

            //modalInstance.result.then(function (data) {
            //    if (data) {
            //        sessionStorage.setItem("clientInfo", JSON.stringify(data));
            //        clientFactory.setClient(data);
            //        window.location.reload();
            //    }
            //}, function () {

            //});
            sessionStorage.setItem("isClientSite", "yes");
        } else if (clientInfo && (clientInfo != 'undefined')) {
            var _client = JSON.parse(clientInfo);
            $scope.ClientSiteId = _client.ClientSiteId;
        }
    }

    //Watch expressions to get Client value. 
    $scope.$watch(function () {
        return languageFactory.getLanguage();
    }, function (newValue, oldValue) {
        if (newValue != oldValue && newValue) {
            $scope.language = newValue;
            $rootScope.lang = $scope.language.CountryCode;
            $translate.use($scope.language.CountryCode);
            $scope.selectClient();

            $scope.loadData();
            $scope.loadPlant();
            $scope.createToggle();
            //if ($scope.isPageLoad) {
            //    $scope.loadData();
            //}
        }
    });




    $scope.loadPlant = function () {
        $scope.PlantDDL = [];
        $scope.defaultplant = {
            PlantAreaId: null,
            PlantAreaName: "--Select--"
        };
        var _url = "/Plant/GetPlantByStatus?lId=" + $scope.language.LanguageId + "&csId=" + $scope.ClientSiteId + "&status=Y";
        $http.get(_url)
            .then(function (response) {
                $scope.PlantDDL = response.data;
                $scope.PlantDDL.splice(0, 0, $scope.defaultplant);
            });
    };


    $scope.save = function () {
        if ($scope.userForm.$valid && !($scope.isProcess) && !($scope.readOnlyPage)) {
            $scope.isProcess = true;
            var postUrl = "/Area/Create";

            $http.post(postUrl, JSON.stringify($scope.Area)).then(function (response) {
                if (response.data) {
                    if (response.data.toString().indexOf("<!DOCTYPE html>") >= 0) {
                        alertFactory.setMessage({
                            type: "warning",
                            msg: "NotPrivileged"
                        });
                    }
                    else {
                        alertFactory.setMessage({
                            msg: "Data saved Successfully"
                        });
                        $scope.loadData();
                        $scope.clearModal();
                    }
                }
                $scope.isProcess = false;
            }, function (response) {
                $scope.isProcess = false;
                if (response.data.message) {
                    alertFactory.setMessage({
                        type: "warning",
                        msg: String(response.data.message),
                        exc: String(response.data.exception)
                    });
                }
            });
        }
    };

    $scope.update = function () {
        if ($scope.userForm.$valid && !($scope.isProcess) && !($scope.readOnlyPage)) {
            $scope.isProcess = true;
            var postUrl = "/Area/Update";
            $scope.Area.LanguageId = $scope.language.LanguageId;
            $http.post(postUrl, JSON.stringify($scope.Area)).then(function (response) {
                if (response.data) {
                    if (response.data.toString().indexOf("<!DOCTYPE html>") >= 0) {
                        alertFactory.setMessage({
                            type: "warning",
                            msg: "NotPrivileged"
                        });
                    }
                    else {
                        alertFactory.setMessage({
                            msg: "Data updated Successfully"
                        });
                        $scope.loadData();
                    }
                }
                $scope.isProcess = false;
            }, function (response) {
                $scope.isProcess = false;
                if (response.data.message) {
                    alertFactory.setMessage({
                        type: "warning",
                        msg: String(response.data.message),
                        exc: String(response.data.exception)
                    });
                }
            });
        }
    };

    $scope.multiLanguage = function (row) {
        $http.get("/Area/GetTransArea?aId=" + row.AreaId)
            .then(function (response) {
                angular.forEach(response.data, function (val, i) {
                    val.sno = i + 1;
                });

                var modalInstance = $uibModal.open({
                    templateUrl: 'skfMultiLanguageModal.html',
                    controller: 'skfMultiLanguageModalCtrl',
                    size: 'lg',
                    backdrop: 'static',
                    keyboard: false,
                    resolve: {
                        params: function () {
                            return { "row": row, "data": response.data };
                        }
                    }
                });
                modalInstance.result.then(function (gridData) {
                    $scope.loadData();
                }, function () {
                    $scope.loadData();
                });
            });

    };


    //$scope.clone = function (row, Type) {
    //    var AreaId;
    //    if (Type == 'AR') {
    //        AreaId = row.entity.AreaId;
    //    }
    //    else {
    //        alertFactory.setMessage({
    //            type: "warning",
    //            msg: "Unit does not match, Please Contact Support!!!",
    //            exc: "Please check the Unit Type Code."
    //        });
    //        return false;
    //    }

    //    var modalInstance = $uibModal.open({
    //        templateUrl: 'skfClonePopupModal.html',
    //        controller: 'skfCloneCtrl',
    //        size: 'md',
    //        backdrop: 'static',
    //        keyboard: false,
    //        resolve: {
    //            params: function () {
    //                return { Type: Type, AreaId: AreaId, "languageId": $scope.language.LanguageId, "AreaName": row.entity.AreaName };
    //            }
    //        }
    //    });

    //    modalInstance.result.then(function (data) {
    //        if (data) {
    //            $scope.loadData();
    //        }
    //    }, function () {
    //    });
    //}



});

