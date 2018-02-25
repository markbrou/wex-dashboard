/**
 * @author v.lugovsky
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.pages.order-management', [])
      .config(routeConfig);

  /** @ngInject */
  function routeConfig($stateProvider) {
    $stateProvider
        .state('order-management', {
          url: '/order-management',
          templateUrl: 'app/pages/order-management/order-management.html',
          title: 'Orders',
          sidebarMeta: {
            icon: 'ion-document',
            order: 0,
          },
        });
  }

})();
