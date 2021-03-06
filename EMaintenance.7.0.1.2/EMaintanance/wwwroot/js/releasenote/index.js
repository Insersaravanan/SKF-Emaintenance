﻿app.requires.push('commonMethods', 'ngTouch', 'ui.grid', 'ui.grid.selection', 'ui.grid.resizeColumns', 'ui.grid.edit', 'ui.grid.cellNav', 'ui.grid.pinning', 'ui.grid.exporter', 'ui.bootstrap', 'ui.grid.selection');
app.controller('skfCtrl', function ($scope, $filter, uiGridConstants, $http, $uibModal, languageFactory, apiFactory, alertFactory, $timeout, $sce) {

    $scope.loadReleaseNotes = function () {
        var _url = "/Lookup/GetLookupByName?lId=" + $scope.language.LanguageId + "&lName=ReleaseNotes";
        $http.get(_url)
            .then(function (response) {
                $scope.ReleaseNotesDDL = response.data;
            });
    };

    $scope.$watch(function () {
        return languageFactory.getLanguage();
    }, function (newValue, oldValue) {
        if (newValue != oldValue && newValue) {
            $scope.language = newValue;
            $scope.loadReleaseNotes();
        }
    });
    $scope.ViewDocument = function (data, index) {
        $scope.noteindex = index;
        $scope.ReleaseContent = null;
        $http.get("/PageSetup/GetContentByTypeCode?typeCode=" + data).then(function (response) {
            if (response.data) {
                $scope.ReleaseContent = response.data.typeText;
            }
        });
    };
});