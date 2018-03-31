<!DOCTYPE html>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<title>userCenter</title>
<body>
<h1 id="Welcome" style="text-align:center">Hello!</h1>
<h2 id="name_welcome" style="text-align:center"></h2>

<script type="text/javascript">
function updateInformation()
{
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			{
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
					window.open("http://localhost:8080/test");
				}
				else
				{
					var userId=result['userId'];
					$.ajax({
						url:"http://localhost:8080/test/delivery/info.do",
						data:{userId:userId},
						type:'POST',
						dataType:'json',
						async:true,
						success:function(result){
							if(result>0)
							{
								document.getElementById("infoDelivery").innerHTML=result+" new delivery information";
							}
						},
					});
				}
			}
		},
	});
}
var time=setInterval("updateInformation()",5000);
</script>

<style>
	#infoDelivery
	{
		position:absolute;
		top:50px;
		right:50px;
		color: red;
	}

	#infoDemande
	{
		position:absolute;
		top:70px;
		right:50px;
		color: red;
	}
</style>
<p id="infoDelivery"></p>
<p id="infoDemande"></p>

<script type="text/javascript">
function updateDemandeInformation()
{
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			{
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
					window.open("http://localhost:8080/test");
				}
				else
				{
					var userId=result['userId'];
					//alert(userId);
					$.ajax({
						url:"http://localhost:8080/test/demande/info.do",
						data:{sellerId:userId},
						type:'POST',
						dataType:'json',
						async:true,
						success:function(result){
							if(result>0)
							{
								document.getElementById("infoDemande").innerHTML=result+" new demande information";
							}
						},
					});
				}
			}
		},
	});
}
var time=setInterval("updateDemandeInformation()",5000);
</script>

<style>
	#returnToHome
	{
		position:absolute;
		top:30px;
		right:5px;
	}
</style>
<a id="returnToHome" href="http://localhost:8080/test">homwPage</a>


<script type="text/javascript">
<%
	String name=(String)session.getAttribute("userName");
%>
</script>
<input id="user_name_hidden" type="hidden" value="<%=name%>"/>
<script type="text/javascript">
$('#name_welcome').append(document.getElementById("user_name_hidden").value);
</script>
<br/>

<style>
	#userStyle
	{
		position:absolute;
		width:1000px;
		left:220px;
		text-align: center;
	}
</style>
<ul id="userStyle">
	<li style="width:200px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;" onclick="partf()">management</li>
	<li style="width:200px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;" onclick="partff()">delivery</li>
	<li style="width:200px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;" onclick="inverseToDemandes()">demandes</li>
	<li style="width:200px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;" onclick="inverseToInfo()">information</li>
</ul>

<script type="text/javascript">
$("li").mouseover(function(){
	var list=document.getElementsByTagName("li");
	var style="width:200px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;";
	for(var i=0;i<list.length;i++)
	{
		list[i].style=style;
	}
	this.style=style+"background-color:	#FFB5B5;";
});
function partf(){
	$("#part2").hide();
	$("#part1").show();
}
function partff(){
	$("#part1").hide();
	$("#part2").show();
}
function inverseToInfo(){
	window.open("/test/user/inverseInfo.do");
}
function userModifyName()
{
	var r=confirm("submit");
	if(r==true )
	{
		var name=document.getElementById("modifyName").value;
		if(name=="")
		{
		alert("please input the name that you want to change.");
		}
		else
		{
		var p=prompt("password", "xxx");
		$.ajax({
			url: "http://localhost:8080/test/user/verifyUser.do",
			type:'POST',
			async:true,
			data:{userPassword:p},
			dataType:'json',
			success:function(result){
				if(result['status']!="1")
				{
					alert(result['errorMsg']);
				}
				else
				{
					//alert(name);
					$.ajax({
						url: "http://localhost:8080/test/user/modifyName.do",
						type:'POST',
						async:true,
						data:{userChangeName:name},
						dataType:'json',
						success:function(result){
							var response=JSON.stringify(result);
							if(response.indexOf("successfully")>0)
							{
								document.getElementById("name_welcome").innerHTML=name;
							}
							alert(response);
							document.getElementById("responseUserModifyName").innerHTML="your new name is: "+response;
							},
						error:function(){
							alert('change name error.');
							window.location.href="http://localhost:8080/test";
						}
				});	
				}
			},
		});
	 }
	}
	else
		{
		alert("demande annule");
		}
}

function userModifyPassword()
{
		var r=confirm("submit");	
		if(r==true)
		{
			var pw=document.getElementById("modifyPassword").value;
			pw=pw.toString();
			if(pw=="")
			{
				alert("please input the password that you want to change.");
			}
			else
			{
				var p=prompt("password", "xxx");
				$.ajax
				({
					url: "http://localhost:8080/test/user/verifyUser.do",
					type:'POST',
					async:true,
					data:{userPassword:p},
					dataType:'json',
					success:function(result)
					{
						if(result['status']!="1")
						{
							alert(result['errorMsg']);
							//alert("123");
						}
						else
						{
							$.ajax({
								url: "http://localhost:8080/test/user/modifyPassword.do",
								type:'POST',
								async:true,
								data:{userChangePassword:pw},
								dataType:'json',
								success:function(result)
								{
									var response=JSON.stringify(result);
									alert(response);
									//alert("456");
									if(response.indexOf("again")>0)
									{
										window.location.href="http://localhost:8080/test";
									}
								},
								error:function()
								{
									alert('change password error.');
									window.location.href="http://localhost:8080/test";
								}
							});	
						}
					},
				});
			}
		}		
	else
	{
		alert("demande annule");
	}
}

function inverseToDemandes(){
	$.ajax({
		url:"/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			{
				if(result['status']=="0")
				{
					alert(result['errorMsg'])
				}
				else
				{
					var userId=result['userId'];
					var url="/test/user/inverseDemandes.do?userId="+userId;
					window.open(url);
				}
			}
		}
	});
}

function userSearchNowAt(){
	var id=document.getElementById("userEnterDemandeId_forSearchDelivery").value;
	//alert(id);
	$.ajax({
		url:"/test/user/userSearchNowArriveAt.do",
		type:'POST',
		data:{deliveryId:id},
		dateType:'json',
		async:true,
		success:function(result){
			var response=JSON.stringify(result);
			alert(result);
			document.getElementById("now_arrive").innerHTML=result;
			
		},
		error:function(){
			alert("error.");
		},
	});
}
</script>

<style>
	#part1
	{
		display:none;
		position:absolute;
		top:300px;
		left:400px;
		text-align: left;
	}
	#part2
	{
		display:none;
		position:absolute;
		top:300px;
		left:400px;
		text-align: left;
	}
</style>
<div id="part1">
<p>1: modifyName:<input id="modifyName" type="text">&nbsp;<button onclick="userModifyName()">verify</button></p><p id="responseUserModifyName"></p><br/>
<p>2: modifyPassword:<input id="modifyPassword" type="text">&nbsp;<button onclick="userModifyPassword()">verify</button></p>
</div>

<div id="part2">
<p>user search delivery now at:</p>
<p>input your deliveryId;
<input id="userEnterDemandeId_forSearchDelivery" type="text">
<button onclick="userSearchNowAt()">search</button></p>
<p>now Arrive at:</p>
<p id="now_arrive"></p>
</div>


<script type="text/javascript">
/**
var tabs=document.getElementsByClassName("function-head")[0].getElementsByTagName('li');
var t=tabs.length;
var contents = document.getElementsByClassName('function-content')[0].getElementsByTagName('div');
for(var i = 0, len = tabs.length; i < len; i++) 
{
    tabs[i].onclick = showTab;
}
function showTab()
{
	for(var i = 0, len = tabs.length; i < len; i++) 
	{
        if(tabs[i] === this) 
        {
            contents[i].style="display:block;"; 
        } else 
        {
           
        	contents[i].style = "display:none;";
        }
    }
}*/
</script>
<br/>
<br/>

<style>
#outButton{
position:absolute;
top:50px;
left:50px;
}
</style>
<button id="outButton" onclick="userLogOut()">logOut</button>
<script type="text/javascript">
	function userLogOut(){
		$.ajax({
			url:"/test/user/logOut.do",
			type:'GET',
			dateType:'json',
			async:true,
			success:function(result){
				//var response=JSON.stringify(result);
				alert(result);
				window.location.href="http://localhost:8080/test";
			},
			error:function(){
				alert("error.");
				window.location.href="http://localhost:8080/test";
			},
		});
	}
</script>



</body>
</html>


