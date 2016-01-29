# ## Widget toggle
# @author Alex Suslov <suslov@me.com>
'use strict'
angular.module('widgets',[])
.directive 'toggle',  ->
  # console.log '---- toggle widget start'
  # led colors
  colors = [
    'grey', 'green', 'red', 'black', 'blue', 'orange', 'white', 'yellow'
  ]
  # ### template
  # <img style="float:left;padding-top:2px;" src="./img/led/led_{{color}}.png">
  template = '''
<i class='ion-ios-lightbulb im-{{color}}' style='font-size: 32px;'></i>
&nbsp;&nbsp; {{descr}}
<label class="toggle">
  <input type="checkbox"
    ng-model="status"
    ng-checked="status"
    ng-change="change()">
  <div class="track">
    <div class="handle"></div>
  </div>
</label>'''
  # console.log 'template', template

  # ### link
  link = (scope) ->
    # console.log '---- toggle widget link'

    # widget model
    widget = scope.ngModel

    # set description
    scope.descr = widget.get('descr') || ''

    # toggle
    scope.status = false
    value = widget.get('value')
    console.log 'value', value
    scope.status = !!value.status if value

    # indicator
    scope.color = 'grey'
    idx = colors.indexOf(widget.get('color'))
    scope.color = colors[idx] if idx isnt -1 if scope.status

  # ### controller
  controller = ($scope) ->
    widget = $scope.ngModel

    widget.on 'change', ->
      # console.log 'widget.update', widget.data()
      link $scope
      $scope.$apply()

    $scope.change = ->
      status = if $scope.status then 1 else 0
      # console.log 'widget status:', status
      widget.pub "#{status}"

  directive =
    restrict: 'E'
    priority: 10
    scope: ngModel: '='
    template: template
    controller: controller
    link: link


# ## Widget fillgauge
# @author Alex Suslov <suslov@me.com>
'use strict'
angular.module('widgets')

.directive 'fillgauge',  ->
  # ### template
  # <img style="float:left;padding-top:2px;" src="./img/led/led_{{color}}.png">
  template = '''
<div ng-class="'{{cfg.class2}}'" style="{{cfg.style2}}">
  {{cfg.descr}}
</div>
<div ng-class="'{{cfg.class3}}'" style="{{cfg.style3}}">
  <svg id="fillgauge{{item.id}}" width="100" height="100"
    ng-init="FillGaugeUpdate(config.id, config.status)">
  </svg>
</div>'''
  # console.log 'template', template

  # ### link
  link = (scope) ->
    # widget model
    widget = scope.ngModel
    scope.config = scope.ngModel.data()

  # ### controller
  controller = ($scope) ->
    widget = $scope.ngModel

    widget.on 'change', ->
      link $scope
      $scope.$apply()

  directive =
    restrict: 'E'
    priority: 10
    scope: ngModel: '='
    template: template
    controller: controller
    link: link


