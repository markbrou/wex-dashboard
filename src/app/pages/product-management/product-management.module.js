/**
 * @author v.lugovsky
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.pages.product-management', [])
      .config(routeConfig);

  /** @ngInject */
  function routeConfig($stateProvider) {
    $stateProvider
        .state('product-management', {
          url: '/product-management',
          templateUrl: 'app/pages/product-management/product-management.html',
          title: 'Products',
          sidebarMeta: {
            icon: 'ion-cube',
            order: 0,
          },
        });
  }

})();
