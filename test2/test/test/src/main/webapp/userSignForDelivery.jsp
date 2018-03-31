<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<title>Arrive</title>
<body>
<h1 >Already arrive </h1>
<div id="information">1-information: </div>
<script type="text/javascript">
var param=window.location.search;
param=param.substr(1);
param=window.atob(param);
//$('#information').append(param);
var demandeId=param.split(/[=,&]/)[1];
var bookId=param.split(/[=,&]/)[3];
var deliveryId=param.split(/[=,&]/)[5];
$('#information').append('<ul id="info"><li id="demandeId">demandeId: '+demandeId+'</li><li id="bookId">bookId: '+bookId+'</li><li>deliveryId: '+deliveryId+'</li></ul>');
$.ajax({
	url:"/test/delivery/demandeDelivery.do",
	data:{demandeId:demandeId,bookId:bookId},
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status1']==0)
		{
			$('#info').append(result['errorMsg']);
		}
		else
		{
			$('#info').append('<li>quantity: '+result['demande'].quantity+'</li><li>totalPrice: '+result['demande'].totalPrice+'</li>');		
		}
	}
});
function deliveryArrive(){
	$.ajax({
		url:"/test/delivery/deliveryArrive.do",
		data:{demandeId:demandeId,bookId:bookId},
		async:true,
		dataType:'json',
		success:function(result){
			$('#arriveResponse').append(result);
		}
	});
}
</script>
<button onclick="deliveryArrive()">verify arrive</button>
<div id="arriveResponse"></div>
<br/>
<br/>

<div>2-Comment please</div>
<form>
give score:<br/>
<input type="radio" name="grade" value="5.0">5.0<br/>
<input type="radio" name="grade" value="4.0">4.0<br/>
<input type="radio" name="grade" value="3.0">3.0<br/>
<input type="radio" name="grade" value="2.0">2.0<br/>
<input type="radio" name="grade" value="1.0">1.0<br/>
</form>
<br/>
<br/>

<div>3-comment:</div>
<textarea rows="10" cols="100" id="commentBody">comment here...</textarea>
<button onclick="comment()">submit</button>
<div id="commentResponse"></div>
<script type="text/javascript">
function comment(){
	var demandeId=document.getElementById("demandeId").innerHTML.split(":")[1];
	var bookId=document.getElementById("bookId").innerHTML.split(":")[1];
	$.ajax({
		url:"/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
					window.open("http://localhost:8080/test");
				}
				else
				{
					var userId=result['userId'];
					var grade=document.getElementsByName("grade");
					var i=0
					for(i;i<grade.length;i++)
					{
						if(grade[i].checked)
						{
							grade=grade[i].value;
							break;
						}
					}
					if(i==5)
					{
						alert("please give score.");
					}
					else
					{
						var comment=document.getElementById("commentBody").value;
						$.ajax({
							url:"/test/comment/insertComment.do",
							type:'POST',
							data:{demandeId:demandeId, bookId:bookId,userId:userId,bookComment:comment,grade:grade},
							async:true,
							dataType:'json',
							success:function(result){
								$('#commentResponse').append(result);
							}
						});
					}
				}
			}
		});
}
</script>



</body>
</html>