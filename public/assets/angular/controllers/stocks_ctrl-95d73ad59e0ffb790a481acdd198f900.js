app.controller("StocksCtrl",["$scope","$resource",function(o,c){var r=c("/api/stock_infos");o.stocks=r.query()}]);