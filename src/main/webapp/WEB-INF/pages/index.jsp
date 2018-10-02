<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap 4 Website Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
	integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
	crossorigin="anonymous">

<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style>
</style>
<script type="text/javascript">
	$(document).ready(function() {
		getListActor();

		$('#btnSubmit').click(function() {
			var firstName = $('#firstName').val();
			var lastName = $('#lastName').val();
			var lastUpdate = new Date().toISOString();
			var actorData = {
					firstName : firstName,
					lastName : lastName,
					lastUpdate : lastUpdate
			};
			var dataJson = JSON.stringify(actorData);
			$.ajax({
				url : "/SpringMVCHibernateTransaction/add",
				method : "POST",
				data : dataJson,
				cache : false,
				dataType: "json",
				contentType : 'application/json; charset=utf-8',
				/* success : function(data) {
					if(data){
						alert("Inserted new user");					
					}
				},
				error : function(error) {
					console.log(error.message);
				} */
			})
		})

		$(document).on("click", "#myTable tbody tr td #btnDelete", function() {
			var row = $(this).closest("tr"); // Find the row
			var id = row.find(".actorId").text(); // Find the text

			// Let's test it out	    
			deleteData(id);
		});

		$(document).on("click", "#myTable tbody tr td #btnEdit", function() {
			var row = $(this).closest("tr"); // Find the row
			var id = row.find(".actorId").text(); // Find the text
			var firstName = row.find(".firstName").text();
			var lastName = row.find(".lastName").text();
			// Let's test it out	    
			$('#myModal').modal('show');
			$('#inputActorId').val(id);
			$('#inputFirstName').val(firstName);
			$('#inputLastName').val(lastName);
		});

		$(document).on('click', '#btnUpdate', function(){
			var actorId = $('#inputActorId').val();
			var firstName = $('#inputFirstName').val();
			var lastName = $('#inputLastName').val();
			var lastUpdate = new Date().toISOString();
		    updateData(actorId, firstName, lastName, lastUpdate);
		});
		
	});

	function updateData(actorId, firstName, lastName, lastUpdate) {
		var actorData = {
				actorId: actorId,
				firstName : firstName,
				lastName : lastName, 
				lastUpdate : lastUpdate
		};
		var dataJson = JSON.stringify(actorData);
		$.ajax({
			url : "/SpringMVCHibernateTransaction/update",
			method : "POST",
			data : dataJson,
			cache : false,
			dataType: "json",
			contentType : 'application/json; charset=utf-8',
			success : function(data) {
				if(data){
					alert("update");
				}
			},
			error : function(error) {
				console.log(error.message);
			}
		})
	}
	
	function deleteData(id) {
		$.ajax({
			url : "http://localhost:8080/SpringMVCHibernateTransaction/delete",
			method : "POST",
			data : JSON.stringify({userId : id}), 
			cache : false,
			processData: false,
			dataType: "json",
			contentType : 'application/json; charset=utf-8',
			success : function(data) {
				if(data){
					$('#'+id).remove();
				}
			},
			error : function(error) {
				console.log(error.message);
			}
		})
	}

	function getListActor() {
		$
				.ajax({
					url : "/SpringMVCHibernateTransaction/actor",
					method : "GET",
					dataType : "JSON",

					success : function(data) {
						/* console.log(data) */
						data
								.forEach(function(element) {
									$('#myTable tr:last')
											.after(
													'<tr id="'+element.actorId+'"><td class="actorId">'
															+ element.actorId
															+ '</td><td class="firstName">'
															+ element.firstName
															+ '</td><td class="lastName">'
															+ element.lastName
															+ '</td><td><i id="btnDelete" class="fas fa-trash"></i></td><td><i id="btnEdit" class="fa fa-edit"></i></td></tr>');
								})
					},
					error : function(error) {
						console.log(error.message)
					}
				})
	}
</script>
</head>
<body>
	<div class="jumbotron text-center" style="margin-bottom: 0;">
		<h1>Spring Demo App</h1>
	</div>

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<form style="margin-left: 100px;" class="form-inline" action="">
			<input id="firstName" class="form-control mr-sm-2" type="text"
				placeholder="Firstname"> <input id="lastName"
				class="form-control mr-sm-2" type="text" placeholder="Lastname">
			<button id="btnSubmit" class="btn btn-success" type="submit">Add</button>
		</form>
	</nav>
	<br>

	<div class="container">
		<h2>List Actors</h2>
		<table class="table table-hover" id="myTable">
			<thead>
				<tr>
					<th>ID</th>
					<th>Firstname</th>
					<th>Lastname</th>
					<th>Delete</th>
					<th>Update</th>
				</tr>
			</thead>
			<tbody>
				<tr></tr>
			</tbody>
		</table>
	</div>

	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Update User Information</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<form style="margin: 10px;" action="">
					<input type="hidden" id="inputActorId">
					<div class="form-group">
						<label>First Name:</label> <input type="text"
							class="form-control" id="inputFirstName">
					</div>
					<div class="form-group">
						<label>Last Name:</label> <input type="text"
							class="form-control" id="inputLastName">
					</div>
					<button type="submit" id="btnUpdate" class="btn btn-primary">Update</button>
				</form>

			</div>
		</div>
	</div>

</body>
</html>