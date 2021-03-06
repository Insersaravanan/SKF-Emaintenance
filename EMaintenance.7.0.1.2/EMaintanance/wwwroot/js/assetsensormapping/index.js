﻿app.requires.push('commonMethods', 'ngTouch', 'ui.grid', 'ui.grid.selection', 'angucomplete-alt', 'ui.grid.resizeColumns', 'ui.grid.edit', 'ui.grid.cellNav', 'ui.grid.pinning', 'ui.grid.exporter');

app.controller('skfCtrl', function ($scope, $filter, uiGridConstants, $http, $uibModal, $window, languageFactory, alertFactory, $timeout, clientFactory) {
    $scope.startIndex = 1;
    $scope.formatters = {};
    $scope.language = null;
    $scope.isAsset = false;

    $scope.loadData = function () {
        var _url = "/AssetSensorMapping/GetAssetHierarchy?lId=" + $scope.language.LanguageId + "&cId=" + $scope.ClientSiteId;
        $http.get(_url)
            .then(function (response) {
                $scope.data = JSON.parse(response.data[0].ClientSite);
                $scope.ObserverDBId = $scope.data[0].ObserverDBId;
            });
    };

    $scope.expandTree = function () {
        if ($scope.isExpand) {
            $scope.isExpand = false;
            $scope.loadData();
            $scope.cancel();
        } else {
            $scope.isExpand = true;
            for (i = 0; i < $scope.data[0].PlantArea.length; i++) {
                $scope.data[0].PlantArea[i].Toggle = !$scope.data[0].PlantArea[i].Toggle;
                if ($scope.data[0].PlantArea[i].Equipments) {
                    for (j = 0; j < $scope.data[0].PlantArea[i].Equipments.length; j++) {
                        $scope.data[0].PlantArea[i].Equipments[j].Toggle = !$scope.data[0].PlantArea[i].Equipments[j].Toggle;
                        for (k = 0; k < $scope.data[0].PlantArea[i].Equipments[j].Units.length; k++) {
                            $scope.data[0].PlantArea[i].Equipments[j].Units[k].Toggle = !$scope.data[0].PlantArea[i].Equipments[j].Units[k].Toggle;
                            if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === 'DR' && $scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit) {
                                for (l = 0; l < $scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit.length; l++) {
                                    $scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit[l].Toggle = !$scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit[l].Toggle;
                                }
                            }
                            if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === 'IN' && $scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit) {
                                for (l = 0; l < $scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit.length; l++) {
                                    $scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit[l].Toggle = !$scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit[l].Toggle;
                                }
                            }
                            if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === 'DN' && $scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit) {
                                for (l = 0; l < $scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit.length; l++) {
                                    $scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit[l].Toggle = !$scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit[l].Toggle;
                                }
                            }
                        }
                    }
                }
            }
        }
        $scope.cancel();
    };

    $scope.selectClient = function () {
        var clientInfo = sessionStorage.getItem("clientInfo");
        clientFactory.setClient(clientInfo);

        if (clientInfo === null) {

            sessionStorage.setItem("isClientSite", "yes");
        } else if (clientInfo && (clientInfo !== 'undefined')) {
            var _client = JSON.parse(clientInfo);
            $scope.ClientSiteId = _client.ClientSiteId;
            $scope.ObserverClientNodeId = _client.ObserverNodeId;
            $scope.ClientSiteDDL = _client;
        }
    };

    $scope.loadObserverSensors = function (data) {
        $scope.SensorDDL = [];
        var _url = "/Lookup/GetLookupByName?lId=" + $scope.language.LanguageId + "&lName=Observer_URL_END_POINT";
        $http.get(_url)
            .then(function (response) {
                $scope.Observer_Sensor_URL = response.data[0].LValue;
                if (data) {
                    $http({
                        method: "GET",
                      //  url: $scope.Observer_Sensor_URL + "InvokeObserver/GetOSensors/228/" + data
                        url: $scope.Observer_Sensor_URL + "/InvokeObserver/GetOSensors/" + $scope.ObserverDBId + "/" + data

                    }).then(function (response) {
                        $scope.SensorDDL = response.data;
                        $scope.filterSensor();
                    });
                }
                });
    };
    
    $scope.filterSensor = function () {
        if ($scope.SensorDetail.Shaft) {
            let slength = $scope.SensorDetail.Shaft.length;
            for (let i = 0; i < slength; i++) {
                if ($scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors === null) {
                    $scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors = [];
                }
                if ($scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors === null) {
                    $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors = [];
                }
                var mappedSensor = $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors.concat($scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors);
            }
            $scope.ObserverSensorDDL = $scope.SensorDDL.filter((item) => {
                return !mappedSensor.some((b) => {
                    if (b === null) {
                        return;
                    }
                    return item.IDNode === b.IDNode;
                });
            });
        }
    };
    $scope.selectedRow = null;

    $scope.ShowAsset = function (_, d, m, a, b, c,cId,PId) {
        $scope.EMaintClientName = a;
        $scope.EMaintPlantArea = b;
        $scope.EMaintEquipment = c;
        $scope.unitType = _;
        $scope.isAsset = true;
        $scope.SClientId = cId;
        $scope.SPlantId = PId;
        $scope.isSensorInvalid = false;

        switch ($scope.unitType) {
            case 'DR':
                $scope.selectedUnitId = d;
                $scope.selectedUnitType = "Drive Unit";
                break;
            case 'IN':
                $scope.selectedUnitId = d;
                $scope.selectedUnitType = "Intermediate Unit";
                break;
            case 'DN':
                $scope.selectedUnitId = d;
                $scope.selectedUnitType = "Driven Unit";
                break;
        }
        //if (m === "true") {
        //    $scope.isMapped = true;
        //} else {
        //    $scope.isMapped = false;         
        //}

        var _url = "/AssetSensorMapping/GetObserverUnitMapping?uType=" + _ + "&uId=" + d + "&lId=" + $scope.language.LanguageId;
        $http.get(_url)
            .then(function (response) {
                var data = JSON.parse(response.data[0].Unit);
                $scope.SensorDetail = data[0];
                $scope.loadObserverSensors($scope.SensorDetail.ObserverNodeId);
            });
    };

    $scope.SaveSensor = function (_d, _o, _s) {
        $scope.isSensorInvalid = false;
        if (typeof _d !== 'undefined') {
            var _data = {
                "UnitSensorId": 0,
                "NodePath": _d.NodePath,
                "NodeName": _d.NodeName,
                "IDParent": _.IDParent,
                "IDNode": _d.IDNode,
                "Active": 'Y'
            };
            let slength = $scope.SensorDetail.Shaft.length;
            for (let i = 0; i < slength; i++) {
                if ($scope.SensorDetail.Shaft[i].ShaftOrder === _o) {
                    if ($scope.SensorDetail.Shaft[i].DriveEnd[0].ShaftSide === _s) {
                        if ($scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors === null) {
                            $scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors = [];
                            $scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors.push(_data);
                        } else {
                            $scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors.push(_data);
                        }
                    } else if ($scope.SensorDetail.Shaft[i].NonDriveEnd[0].ShaftSide === _s) {

                        if ($scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors === null) {
                            $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors = [];
                            $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors.push(_data);
                        } else {
                            $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors.push(_data);
                        }

                    }
                }
            }
            $scope.filterSensor();
            $scope.Sensor.IdNode = null;
        }
    };

    $scope.DirtyValues = function (sh, e, j) {
        $scope.ObserverSensorDDL.push(j);
        let slength = $scope.SensorDetail.Shaft.length;
        for (let i = 0; i < slength; i++) {
            if ($scope.SensorDetail.Shaft[i].ShaftOrder === e) {
                if ($scope.SensorDetail.Shaft[i].DriveEnd[0].ShaftSide === sh) {
                    $scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors = $scope.SensorDetail.Shaft[i].DriveEnd[0].Sensors.filter(function (item) {
                        return item !== j;
                    });
                } else if ($scope.SensorDetail.Shaft[i].NonDriveEnd[0].ShaftSide === sh) {
                    $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors = $scope.SensorDetail.Shaft[i].NonDriveEnd[0].Sensors.filter(function (item) {
                        return item !== j;
                    });
                }
            }
        }
    };

    $scope.clearValue = function () {
        $scope.SensorDetail = {
            ObserverNodePath: null,
            ObserverNodeName: null,
            UnitType: null,
            UnitPath: null,
            Shaft: null,
            ObserverNodeId: null,
            EquipmentId: null,
            UnitID: null,
            UserId: 0
        };
        $scope.Sensor = {
            IdNode: null
        };
    }();

    $scope.save = function () {
        if ($scope.unitType !== 'IN') {
            if ($scope.SensorDetail.Shaft[0].DriveEnd[0].Sensors === null) {
                $scope.SensorDetail.Shaft[0].DriveEnd[0].Sensors = [];
            }
            if ($scope.SensorDetail.Shaft[0].NonDriveEnd[0].Sensors === null) {
                $scope.SensorDetail.Shaft[0].NonDriveEnd[0].Sensors = [];
            }
            if ($scope.SensorDetail.Shaft[0].DriveEnd[0].Sensors.length === 0 && $scope.SensorDetail.Shaft[0].NonDriveEnd[0].Sensors.length === 0) {
                alertFactory.setMessage({
                    type: "warning",
                    msg: "Please select the sensor and save."
                });
                return;
            }
        }
        else {
            var IntermediateShaft = [];
            // seperate validation for Intermediate Shafts 
            for (l = 0; l < $scope.SensorDetail.Shaft.length; l++) {
                if ($scope.SensorDetail.Shaft[l].DriveEnd[0].Sensors === null) {
                    $scope.SensorDetail.Shaft[l].DriveEnd[0].Sensors = [];
                }
                if ($scope.SensorDetail.Shaft[l].NonDriveEnd[0].Sensors === null) {
                    $scope.SensorDetail.Shaft[l].NonDriveEnd[0].Sensors = [];
                }
                if ($scope.SensorDetail.Shaft[l].DriveEnd[0].Sensors.length !== 0) {
                    IntermediateShaft.push($scope.SensorDetail.Shaft[l].DriveEnd[0].Sensors);
                }
                if ($scope.SensorDetail.Shaft[l].NonDriveEnd[0].Sensors.length !== 0) {
                    IntermediateShaft.push($scope.SensorDetail.Shaft[l].NonDriveEnd[0].Sensors);
                }
            }
            if (IntermediateShaft.length === 0) {
                alertFactory.setMessage({
                    type: "warning",
                    msg: "Please select the sensor for atleast one shaft and save."
                });
                return;
            }
        }
            for (k = 0; k < $scope.SensorDetail.Shaft.length; k++) {
                if ($scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors.length > 0) {
                    for (i = 0; i < $scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors.length; i++) {
                        if (!$scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors[i].Warning || !$scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors[i].Alarm || !$scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors[i].EUnitId || !$scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors[i].SensorTitle || !$scope.SensorDetail.Shaft[k].DriveEnd[0].Sensors[i].NodeName) {
                            $scope.isSensorInvalid = true;
                            alertFactory.setMessage({
                                type: "warning",
                                msg: "Please fill all the required fields for Sensors."
                            });
                            return;
                        }
                    }
                }
                if ($scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors.length > 0) {
                    for (j = 0; j < $scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors.length; j++) {
                        if (!$scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors[j].Warning || !$scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors[j].Alarm || !$scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors[j].EUnitId || !$scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors[j].SensorTitle || !$scope.SensorDetail.Shaft[k].NonDriveEnd[0].Sensors[j].NodeName) {
                            $scope.isSensorInvalid = true;
                            alertFactory.setMessage({
                                type: "warning",
                                msg: "Please fill all the required fields for Sensors."
                            });
                            return;
                        }
                    }
                }
        }
        var postUrl = "/AssetSensorMapping/Create";
        $scope.SensorDetail.UserId = 0;
        $scope.SensorDetail.ClientSiteId = $scope.SClientId;
        $scope.SensorDetail.PlantAreaId = $scope.SPlantId;
       
            $http.post(postUrl, JSON.stringify($scope.SensorDetail)).then(function (response) {
                if (response.data) {
                    if (response.data.toString().indexOf("<!DOCTYPE html>") >= 0) {
                        alertFactory.setMessage({
                            type: "warning",
                            msg: "User not a privileged to perform this Action. Please Contact your Admin.."
                        });
                    }
                    else {
                        alertFactory.setMessage({
                            msg: "Data saved Successfully."
                        });
                        $scope.ShowAsset($scope.unitType, $scope.selectedUnitId, null, $scope.EMaintClientName, $scope.EMaintPlantArea, $scope.EMaintEquipment,$scope.SClientId,$scope.SPlantId );
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
        //}
    };

    $scope.ToggleFilter = function (item) {
        item.Toggle = !item.Toggle;
    };

    //Watch expressions to get Language value. 
    $scope.$watch(function () {
        return languageFactory.getLanguage();
    }, function (newValue, oldValue) {
        if (newValue !== oldValue && newValue) {
            $scope.language = newValue;
            $scope.selectClient();
            $scope.loadData();
            $scope.loadOrientation();
            $scope.loadSensorType();
            $scope.loadEUnit();
        }
    });

    $scope.showMode1 = true;
    $scope.showMode2 = $scope.showMode3 = $scope.showMode4 = $scope.showMode5 = $scope.showMode6 = false;
    $scope.showAcc = function (data) {
        $scope.showMode1 = $scope.showMode2 = $scope.showMode3 = $scope.showMode4 = $scope.showMode5 = $scope.showMode6 = false;
        switch (data) {
            case 1:
                $scope.showMode1 = true;
                break;
            case 2:
                $scope.showMode2 = true;
                break;
            case 3:
                $scope.showMode3 = true;
                break;
            case 4:
                $scope.showMode4 = true;
                break;
            case 5:
                $scope.showMode5 = true;
                break;
            case 6:
                $scope.showMode6 = true;
                break;
        }
    };

    $scope.cancel = function () {
        $scope.isAsset = false;
        $scope.selectedUnitId = null;
    };

    $scope.loadOrientation = function (data) {
        $scope.defaultSensorOrientation = {
            LookupId: null,
            LValue: "--Select--"
        };
        var _url = "/Lookup/GetLookupByName?lId=" + $scope.language.LanguageId + "&lName=SensorOrientation";
        $http.get(_url)
            .then(function (response) {
                $scope.SensorOrientationDDL = response.data;
                $scope.SensorOrientationDDL.splice(0, 0, $scope.defaultSensorOrientation);
            });
    };
    $scope.loadSensorType = function () {
        $scope.defaultSensorType = {
            LookupId: null,
            LValue: "--Select--"
        };
        var _url = "/Lookup/GetLookupByName?lId=" + $scope.language.LanguageId + "&lName=OBSENSORTYPE";
        $http.get(_url)
            .then(function (response) {
                $scope.SensorTypeDDL = response.data;
                $scope.SensorTypeDDL.splice(0, 0, $scope.defaultSensorType);
            });
    };
    $scope.loadEUnit = function () {
        $scope.defaultEUnit = {
            EUnitId: null,
            EUName: "--Select--"
        };
        var _url = "/AssetSensorMapping/GetEunit?Type=OBEUnit" + "&lId=" + $scope.language.LanguageId + "&sId=null&sId1=null";
        $http.get(_url)
            .then(function (response) {
                $scope.EUnitDDL = response.data;
                $scope.EUnitDDL.splice(0, 0, $scope.defaultEUnit);
            });
    };
    $scope.assetMapping = function (data) {
        $scope.selectClient();
        $scope.LanguageID = $scope.language.LanguageId;
        var modalInstance = $uibModal.open({
            templateUrl: 'skfAssetMappingSensorModal.html',
            controller: 'skfAssetMappingSensorModal',
            size: 'md',
            backdrop: 'static',
            keyboard: false,
            resolve: {
                params: function () {
                    return { "data": data, "ClientSiteId": $scope.ClientSiteId, "ObserverDBId": $scope.ObserverDBId, "LanguageId": $scope.LanguageID, "UnitType": $scope.selectedUnitType, "ObserverClientNodeId": $scope.ObserverClientNodeId };
                }
            }
        });
        modalInstance.result.then(function (data) {
            $scope.ShowAsset(data.UnitType, data.UnitID, null, $scope.EMaintClientName, $scope.EMaintPlantArea, $scope.EMaintEquipment, $scope.SClientId, $scope.SPlantId );
            for (i = 0; i < $scope.data[0].PlantArea.length; i++) {
                if ($scope.data[0].PlantArea[i].Equipments) {
                    for (j = 0; j < $scope.data[0].PlantArea[i].Equipments.length; j++) {
                        for (k = 0; k < $scope.data[0].PlantArea[i].Equipments[j].Units.length; k++) {

                            if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === data.UnitType) {
                                if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === 'DR' && $scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit) {
                                    for (l = 0; l < $scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit.length; l++) {
                                        if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit[l].UnitId === data.UnitID) {
                                            $scope.data[0].PlantArea[i].Equipments[j].Units[k].DriveUnit[l].IsOAssetMapped = true;
                                            break;
                                        }
                                    }
                                }
                                if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === 'IN' && $scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit) {
                                    for (l = 0; l < $scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit.length; l++) {
                                        if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit[l].UnitId === data.UnitID) {
                                            $scope.data[0].PlantArea[i].Equipments[j].Units[k].IntermediateUnit[l].IsOAssetMapped = true;
                                            break;
                                        }
                                    }
                                }
                                if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].UnitType === 'DN' && $scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit) {
                                    for (l = 0; l < $scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit.length; l++) {
                                        if ($scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit[l].UnitId === data.UnitID) {
                                            $scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit[l].IsOAssetMapped = true;
                                            //console.log($scope.data[0].PlantArea[i].Equipments[j].Units[k].DrivenUnit);
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }, function () {
        });
    };
    $scope.clientMapping = function (data) {
        $scope.LanguageID = $scope.language.LanguageId;
        var modalInstance = $uibModal.open({
            templateUrl: 'skfClientMappingSensorModal.html',
            controller: 'skfClientMappingSensorModalCtrl',
            size: 'lg',
            backdrop: 'static',
            keyboard: false,
            resolve: {
                params: function () {
                    return { "data": data, "ClientSiteId": $scope.ClientSiteId, "LanguageId": $scope.LanguageID  };
                }
            }
        });
        modalInstance.result.then(function () {
            $scope.loadData();
            $http.get("/UserClientSiteRel/GetUserClientSites?lId=" + $scope.language.LanguageId + "&type=ClientSite&cId=&ccId=").then(function (response) {
                for (i = 0; i <= response.data.length; i++) {
                    if (response.data[i]){
                        if (response.data[i].ClientSiteId === $scope.ClientSiteId) {
                            sessionStorage.setItem("clientInfo", JSON.stringify(response.data[i]));
                        }
                    }
                }
            });
            $scope.selectClient();
           
        }, function () {
        });
    };
});

app.controller('skfAssetMappingSensorModal', function ($scope, alertFactory, $http, $uibModalInstance, params) {
    $scope.EMaintAssetName = params.data.IdentificationName;
    $scope.ObserverDBId = params.data.ObserverDBId;
    $scope.selectedAssetTye = params.UnitType;
    $scope.SelectedObserver = {};
    $scope.loadObserverAssetDDL = function () {
        $scope.Assetdata = [];
        $http.get("/AssetMapping/GetAssetMappingList?cId=" + params.ClientSiteId + "&lId=" + params.LanguageId)
            .then(function (response) {
                $scope.mappingAsset(response.data);
            });
    }();

    $scope.mappingAsset = function (data) {
        let sRow = [];
        sRow = data.filter((item) => {
            return item.ObserverNodeId !== null;
        });
        if (sRow.length > 0) {
            $scope.SelectedRow = sRow.filter((item) => {
                return item.ObserverNodeId !== params.data.ObserverNodeId;
            });
        }
        return $scope.loadObserverAsset();
    };

    $scope.loadObserverAsset = function () {

        var _url = "/Lookup/GetLookupByName?lId=" + params.LanguageId + "&lName=Observer_URL_END_POINT";
        $http.get(_url)
            .then(function (response) {
                $scope.Observer_ENDPOINT_URL = response.data[0].LValue;
                $http({
                    method: 'GET',
                  //  url: $scope.Observer_ENDPOINT_URL + "/InvokeObserver/GetOAssets/168/" + params.ObserverClientNodeId
                      url: $scope.Observer_ENDPOINT_URL + "/InvokeObserver/GetOAssets/" + $scope.ObserverDBId + "/" + params.ObserverClientNodeId

                }).then(function (response) {
                    if (typeof $scope.SelectedRow !== 'undefined') {
                        $scope.AssetsDDL = response.data.filter((item) => {
                            return !$scope.SelectedRow.some((b) => {
                                return item.IDNode === b.ObserverNodeId;
                            });
                        });
                    }
                    else {
                        $scope.AssetsDDL = response.data;
                    }
                });
            });
    };


    $scope.save = function (data) {
        $scope.SelectedObserver = data;
    };

    $scope.saveMapping = function () {
        if (!$scope.SelectedObserver.IDNode) {
            //$scope.SelectedObserver.IDNode = params.row.entity.ObserverNodeId;
            //$scope.SelectedObserver.NodeName = params.row.entity.ObserverNodeName;
            $scope.Selected = {};
            alertFactory.setMessage({
                type: "warning",
                msg: "Please select the asset and save."
            });
            return;
        }
        var headerData = {
            "AssetType": params.data.UnitType,
            "AssetId": params.data.UnitID,
            "ObserverNodeId": $scope.SelectedObserver.IDNode,
            "ObserverNodeName": $scope.SelectedObserver.NodeName,
            "ObserverNodePath": $scope.SelectedObserver.NodePath
        };

        var postUrl = "/AssetMapping/Create";
        $http.post(postUrl, JSON.stringify(headerData)).then(function (response) {
            if (response.data) {
                alertFactory.setMessage({
                    msg: "Data saved Successfully."
                });
                $uibModalInstance.close(params.data);
            }
        }, function (response) {
            if (response.data.message) {
                alertFactory.setMessage({
                    type: "warning",
                    msg: String(response.data.message),
                    exc: String(response.data.exception)
                });
            }
        });
    };

    $scope.cancel = function () {
        $uibModalInstance.dismiss();
    };
});

app.controller('skfClientMappingSensorModalCtrl', function ($scope, alertFactory, $http, $uibModalInstance, params) {
    $scope.ClientName = params.data.ClientSiteName;
    $scope.ClientSiteId = params.data.ClientSiteId;
    $scope.ClientMapping = {
        "ObserverDBId": null,
        "ObserverDBName": null,
        "ObserverNodeId": null,
        "ObserverNodeName": null,
        "ClientSiteId": null,
        "ObserverNodePath": null
    };

    $scope.loadObserverClientDDL = function () {
        $scope.Assetdata = [];
        $http.get("/ClientMapping/GetClientMapping?lId=" + params.LanguageId)
            .then(function (response) {
                $scope.mappingClient(response.data);
            });
    }();

    $scope.mappingClient = function (data) {
        let sRow = [];
        sRow = data.filter((item) => {
            return item.ObserverNodeId !== null;
        });
        if (sRow.length > 0) {
            $scope.SelectedRow = sRow.filter((item) => {
                return item.ObserverNodeId !== params.data.ObserverNodeId;
            });
        }
        return $scope.loadObserverDB();
    };

    $scope.loadObserverDB = function () {
        var _url = "/Lookup/GetLookupByName?lId=" + params.LanguageId + "&lName=Observer_URL_END_POINT";
        $http.get(_url)
            .then(function (response) {
                $scope.Observer_ENDPOINT_URL = response.data[0].LValue;
                $http({
                    method: "GET",
                    url: $scope.Observer_ENDPOINT_URL +"InvokeObserver/GetODBs"
                }).then(function (response) {
                    $scope.ObserverdbDDL = response.data;
                    $scope.ClientMapping.ObserverDBId = 221;
                    $scope.ClientMapping.ObserverDBName = "RMS226AO";
                    $scope.loadObserverClient(221);
                });
            });
    };

    $scope.loadObserverClient = function (data) {
        $scope.ObserverClientDDL = [];
                $http({
                    method: "GET",
                    url: $scope.Observer_ENDPOINT_URL + "InvokeObserver/GetOClients/" + data + "/0"
                }).then(function (response) {
                    if (typeof $scope.SelectedRow !== 'undefined') {
                        $scope.ObserverClientDDL = response.data.filter((item) => {
                            return !$scope.SelectedRow.some((b) => {
                                return item.IDNode === b.ObserverNodeId;
                            });
                        });
                    }
                    else {
                        $scope.ObserverClientDDL = response.data;
                    }
                });
    };

    $scope.SaveODb = function (data) {
        $scope.ClientMapping.ObserverDBName = data.Name;
        $scope.ClientMapping.ObserverDBId = data.Id;
        $scope.loadObserverClient(data.Id);
        $scope.ClientMapping.ObserverNodeId = null;
    };

    $scope.SaveOClient = function (data) {
        $scope.ClientMapping.NodeName = data.NodeName;
        $scope.ClientMapping.IDNode = data.IDNode;
        $scope.ClientMapping.NodePath = data.NodePath;
    };


    $scope.save = function () {
        if (!$scope.ClientMapping.IDNode) {
            $scope.ClientMapping.ObserverNodeId = null;
            alertFactory.setMessage({
                type: "warning",
                msg: "Please select the Observer Client and save."
            });
            return;
        }
        var postData = {
            "ObserverDBId": $scope.ClientMapping.ObserverDBId,
            "ObserverDBName": $scope.ClientMapping.ObserverDBName,
            "ObserverNodeId": $scope.ClientMapping.IDNode,
            "ObserverNodeName": $scope.ClientMapping.NodeName,
            "ObserverNodePath": $scope.ClientMapping.NodePath,
            "ClientSiteId": $scope.ClientSiteId 
        };

        if (!$scope.isProcess) {
            $scope.isProcess = true;
            var postUrl = "/ClientMapping/SaveClientMapping";
            $http.post(postUrl, JSON.stringify(postData)).then(function (response) {
                if (response.status) {
                    if (response.data.toString().indexOf("<!DOCTYPE html>") >= 0) {
                        alertFactory.setMessage({
                            type: "warning",
                            msg: "User not a privileged to perform this Action. Please Contact your Admin.."
                        });
                    }
                    else {
                        alertFactory.setMessage({
                            msg: "Data saved Successfully."
                        });
                        $uibModalInstance.close();
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
    $scope.cancel = function () {
        $uibModalInstance.dismiss();
    };
});