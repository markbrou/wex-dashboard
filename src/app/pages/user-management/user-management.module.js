/**
 * @author v.lugovsky
 * created on 16.12.2015
 */
(function () {
  'use strict';

  angular.module('BlurAdmin.pages.user-management', [])
      .config(routeConfig);

  /** @ngInject */
  function routeConfig($stateProvider) {
    $stateProvider
        .state('user-management', {
          url: '/user-management',
          templateUrl: 'app/pages/user-management/user-management.html',
          title: 'Users',
          sidebarMeta: {
            icon: 'ion-person',
            order: 0,
          },
        });
  }

})();
