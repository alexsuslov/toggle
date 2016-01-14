// ## Widget toggle
// @author Alex Suslov <suslov@me.com>

'use strict';
define(['directives'], function(d) {
  d.directive('toggle', function($compile) {
    var template = '<div></div>'
    function controller($scope) {
      $scope.broker.on( 'change:status change:last change:messages', function(){
        $scope.cls = States[$scope.broker.get('status')];
        $scope.$apply();
      });

    }
    function link(scope, el, attr) {
     scope.cls = States[scope.broker.get('status')];
    }

    return {
      restrict: 'E',
      priority : 10,
      scope: true,
      template: template,
      controller: controller,
      link: link
    }
  });
});