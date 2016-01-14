// ## Widget toggle
// @author Alex Suslov <suslov@me.com>

'use strict';
define(['widgets'], function(d) {
  var debug = false;
  d.directive('toggle', function($compile) {
    // led colors
    var colors = ['grey', , 'green', 'red', 'black', 'blue', 'orange', 'white', 'yellow'];
    // ### template
    var template = [
      '<img style="float:left;padding-top:2px;" src="./img/led/led_{{color}}.png">',
      '&nbsp;&nbsp; {{descr}}',
      '<label class="toggle">',
      '<input type="checkbox" ng-model="status" ng-checked="status" ng-change="change()">',
      '<div class="track"><div class="handle"></div></div>',
      '</label>'
      ].join('');

    // ### controller
    function controller($scope) {
      // widget model
      var widget = $scope.ngModel;
      // updater function
      function updater(){
        // get status
        var status = widget.get('value').status;
        $scope.status = status != 0;
        // color index
        var idx = colors.indexOf( widget.get('color') );
        // set color
        // !important != 0
        $scope.color = ( status != 0 && idx !== -1 ?  colors[idx] : 'grey');
        // set description
        $scope.descr = widget.get('descr');
        $scope.$apply();
      }
      // on
      widget.on( 'change', updater);

      $scope.change = function(){
        var broker = widget.get('broker');
        if (debug) console.log('broker', broker);
        broker.pub( widget.get('topic') + '/control', ($scope.status? '1': "0"), 1);
      }

    }

    // ### link
    function link(scope, el, attr) {
      // widget model
      var widget = scope.ngModel;
      // get status
      if (widget.get('value'))
        var status = widget.get('value').status;
        scope.status = status != 0;
      // color index
      var idx = colors.indexOf( widget.get('color') );
      // set color
      // !important != 0
      scope.color = ( status != 0 && idx !== -1 ?  colors[idx] : 'grey');
      // set description
      scope.descr = widget.get('descr');
    }

    return {
      restrict: 'E',
      priority : 10,
      scope: {ngModel:"="},
      template: template,
      controller: controller,
      link: link
    }
  });
});
