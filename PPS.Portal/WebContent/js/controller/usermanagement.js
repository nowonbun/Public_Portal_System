app.controller("usermanagement", [ '$scope', '_ws', '_loader', '_safeApply', '_extendModal', '_notification', function($scope, _ws, _loader, _safeApply, _extendModal, _notification) {
	_loader.controller.hide();
	_ws.message("usermanagement", "init", function(data) {
		var node = JSON.parse(data);
		var table = $("#tablelist").DataTable({
			ajax : {
				url : node.data,
				type : "POST",
				complete : function() {
					$("#tablelist_wrapper").addClass("box-shadow-0");
					$("#tablelist").css("width", "");
					$("#tablelist thead th").css("width", "");
				},
				error : function(xhr, error, thrown) {
					if(xhr.status === 401){
						_notification("danger", "You don't have permission.");
						location.href = "./#!/"
					}
				}
			},
			ordering : false,
			select : {
				style : 'single'
			},
			columnDefs : [ {
				className : 'control',
				targets : 0,
				data : null,
				defaultContent : ''
			} ],
			responsive : {
				details : {
					type : 'column',
					target : 0
				}
			},
			columns : [ 
				{ data : null }, 
				{ data : "id" }, 
				{ data : "given_name" }, 
				{ data : "name" }, 
				{ data : "nick_name" }, 
				{ data : "company_name" }, 
				{ data : "group_name" }, 
				{ data : "type" }, 
				{ data : "active" } ]
		});
		table.on('select', function(e, dt, type, indexes) {
			if (type === 'row') {
				_safeApply(function() {
					$("#editbtn").prop("disabled", false);
					$("#deletebtn").prop("disabled", false);
					$scope.selectid = table.rows(indexes).data().pluck('id')[0];
				});
			}
		});
		table.on('deselect', function(e, dt, type, indexes) {
			if (type === 'row') {
				_safeApply(function() {
					$("#editbtn").prop("disabled", true);
					$("#deletebtn").prop("disabled", true);
					$scope.selectid = null;
				});
			}
		});
		$scope.userAdd = function() {
			_extendModal("./views/profile.tpl.jsp","useradd",$scope);
		}
		$scope.userEdit = function() {
			_extendModal("./views/profile.tpl.jsp","useredit",$scope);
		}
		$scope.userDelete = function() {
			//location.href = "./#!/userdelete/" + $scope.selectid;
		}
		_loader.controller.show();

	});
	_ws.message("datamastersetting", "permission", function(data) {
		var node = JSON.parse(data);
		_notification(node.type, node.msg);
		location.href="./#!/";
		return;
	});
	_ws.send("usermanagement", "init");
} ]);