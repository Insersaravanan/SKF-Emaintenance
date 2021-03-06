﻿app.requires.push('commonMethods');

app.controller('skfCtrl', function ($scope, $filter, $http, globalInfoFactory, utility, clientFactory, languageFactory, $window) {

    $scope.Report = function () {
       
        var mapForm = document.createElement("form");
        mapForm.method = "POST";
        mapForm.action = "/home";
        mapForm.setAttribute("class", "report-append-view");

        var LanguageId = document.createElement("input");
        LanguageId.type = "text";
        LanguageId.name = "LanguageId";
        LanguageId.value = $scope.language.LanguageId;
        mapForm.appendChild(LanguageId);

        document.body.appendChild(mapForm);
        map = window.open("", "_self", "status=0,title=0,height=600,width=800,scrollbars=1");

        if (map) {
            mapForm.submit();
        } else {
            alert('You must allow popups for this map to work.');
        }
    };

    $scope.$watch(function () {
        return languageFactory.getLanguage();
    }, function (newValue, oldValue) {
        if (newValue != oldValue && newValue) {
            $scope.language = newValue;
            sessionStorage.setItem("isDashboard", "yes");
            $scope.Report();
        }
    });

});
