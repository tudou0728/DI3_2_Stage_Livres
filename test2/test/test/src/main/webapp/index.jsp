<!DOCTYPE html>
<%@ page  language="java" import="java.util.*" contentType="text/html;charset=UTF-8" %>  
<%@ page import="com.controller.*" %>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
<!--
function onbeforeunload () 
{  
    var scrollPos;  
    if (typeof window.pageYOffset != 'undefined') 
    {  
        scrollPos = window.pageYOffset;  
    }  
    else if (typeof document.compatMode != 'undefined' && document.compatMode != 'BackCompat') 
    {  
        scrollPos = document.documentElement.scrollTop;  
    }  
    else if (typeof document.body != 'undefined') 
    {  
        scrollPos = document.body.scrollTop;  
    }  
    document.cookie = "scrollTop=" + scrollPos; //存储滚动条位置到cookies中  
}  
  
function onload () 
{  
    if (document.cookie.match(/scrollTop=([^;]+)(;|$)/) != null)
    {  
        var arr = document.cookie.match(/scrollTop=([^;]+)(;|$)/); //cookies中不为空，则读取滚动条位置  
        document.documentElement.scrollTop = parseInt(arr[1]);  
        document.body.scrollTop = parseInt(arr[1]);  
    }
}  
//-->
</script>

<body onbeforeunload="return onbeforeunload()" onload="return onload()" >
<h1 style="text-align:center;">Hello World! </h1><br/><br/>

<script type="text/javascript">

		function inverseToBook(){
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
						}
						else
						{
							window.open("user/inverseBook.do");
						}
					}
				},
		});		
		}
		

		function inverseToDelivery(){
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
						}
						else
						{
							window.open("user/inverseDelivery.do");
						}
					}
				},
		});			
		}
		
		function inverseToRefund(){
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
						}
						else
						{
							window.open("refund/inverseToRefund.do");
						}
					}
				},
		});		
		}
</script>
<style type="text/css">
#userFunction{
position:absolute;
top:30px;
right:100px;
}
li{list-style: none;}
</style>

<div id="userFunction" > 
	<ul > 
		<li><a href="#" id="mouseChange" >user</a></li>
		<li><a href="#" class="some" style="display:none;" onclick="showWindow()">log in/register</a></li> 
		<li><a href="#" class="some" style="display:none;" onclick="toUser()">user center</a></li> 
		<li><a href="#" class="some" style="display:none;" onclick="userLogOut()">log out</a></li> 
	</ul> 
</div> 
<script type="text/javascript">
var click=0;
$('#mouseChange').click(function(){
	if(click==0)
	{
		$('.some').show();
		click=1;
	}
	else
	{
		$('.some').hide();
		click=0;
	}
});
function toUser(){
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
						windowHide();
					}
					else
					{
						window.open("http://localhost:8080/test/user.do");
						windowHide();
					}
				}
			},
	});
}
$.ajax({
	url:"http://localhost:8080/test/user/verifySession.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result){
		{
			if(result['status']=="0")
			{
				document.getElementById("mouseChange").innerHTML="user";
			}
			else
			{
				var t=JSON.stringify(result['userName']);
				//var tt=document.getElementById("userFunction").value;
				document.getElementById("mouseChange").innerHTML="welcome : "+t.substr(1,t.length-2);
			}
		}
	},
});
<!--
function changeUserHome(){
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			{
				if(result['status']=="0")
				{
					document.getElementById("mouseChange").innerHTML="user";
				}
				else
				{
					var t=JSON.stringify(result['userName']);
					//var tt=document.getElementById("userFunction").value;
					document.getElementById("mouseChange").innerHTML="user : "+t.substr(1,t.length-2);
				}
			}
		},
});
}
//var temp=setInterval("changeUserHome()", 5000)
function stopSet(){
	window.clearInterval(temp);
	alert("stop successfully");
}
//-->
</script>

<div id="div_logInOrRegister"><br/><br/>
	<form action="" method="post" id="formLogIn">LOG IN:<br/>
	userId:<input type="text" name="userId" id="form_userName"><br/>
	userPassword:<input type="password" name="userPassword" id="form_password"><br/>
	<input type="submit" onclick="return logInFunction2()" value="logIn">
	</form>
	<br/>
	<br/>
	<form action="" method="post" id="formRegister">Register:<br/>
	userName：<input id="registerUserName" name="userName" type="text"><br/>
	userPassword:<input id="registerUserPw" name="userPassword" type="text"><br/>
	userPassword again：<input id="registerUserPwAgain" name="userPasswordAgain" type="text"><br/>
	enterprise:<input id="registerUserEnterprise" name="enterprise" type="text"><br/>
	<input type="submit" onclick="return insertUser()" value="Register"><br/><br/>
	<button onclick="windowHide()">quitter</button>
	</form>
</div>
<style type="text/css">
#div_logInOrRegister{
width:400px;
height:400px;
position:absolute;
right:30px;
top:200px;
text-align:center;
vertical-align:middle;
display:none;
background-color: #7B7B7B;
z-index: 5000
}
</style>
<script type="text/javascript">
function showWindow(){
	var form=$('#div_logInOrRegister');
	form.show("slow");
}

function windowHide(){
	var form=$('#div_logInOrRegister');
	form.hide();
}

function logInFunction2()
{		 
	var input=$('#formLogIn').serialize();
	//alert(input);
	$.ajax({
			url: "/test/user/logIn.do",
			type:'POST',
			async:false,
			data:$('#formLogIn').serialize(),
			dataType:'json',
			success:function(result){
				  var d=JSON.stringify(result);	
				  alert(d);
				  window.location.reload();
				},
			error:function(msg){
				alert(msg);
				alert("you gua le");
			}
	});	
}

function insertUser()
{
		var r=confirm("verify submit");
		if(r==true)
		{
		var pw=document.getElementById("registerUserPw").value;
		var pw2=document.getElementById("registerUserPwAgain").value;
		if(pw!=pw2)
		{
			alert("these two passwords are different.");
		}
		else
		{
			
			alert($('#formRegister').serialize());
			$.ajax({
				url:"/test/user/create.do",
				type:'POST',
				data:$('#formRegister').serialize(),
				dataType:'json',
				async:false,
				success:function(result){
					var response=JSON.stringify(result);
					alert(result);
					document.getElementById("responseInserUser").innerHTML=response;
				},
				error:function(){
					alert("you gua le2.");
				},
			});	
		}
	}
		else
			{
			alert("annuler");
			}
} 
function userLogOut(){
	$.ajax({
		url:"/test/user/logOut.do",
		type:'GET',
		dateType:'json',
		async:true,
		success:function(result){
			alert(result);
			windowHide();
			window.location.reload();
		},
		error:function(){
			alert("please log in.");
			windowHide();
		},
	});
}

	function searchBookName(){
	var bookName=document.getElementById("inputSearch").value;
	var name="%"+bookName+"%";
	$.ajax({
		url: "/test/book/searchBookName.do",
			type:'POST',
			async:true,
			data:{bookName:name},
			dataType:'json',
			success:function(result){
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
					document.getElementById("response_searchBookName").innerHTML="0 records";
					document.getElementById("table_searchBookName").innerHTML="";
				}
				else
				{
					var rowLength;
					document.getElementById("table_searchBookName").innerHTML="";
					var table=$('<table border="1" id="searchNameTable">');
					table.appendTo($("#table_searchBookName"));
					var row1=$('<tr></tr>');
					row1.append('<th width=200 id="table_searchBookName_rangeId">range</th>');
					row1.append('<th width=200 id="table_searchBookName_bookId" class="bookId">bookId</th>');
					row1.append('<th width=200 id="table_searchBookName_bookName">bookName</th>');
					//row1.append('<th width=200 id="table_searchBookName_bookQuantity">bookQuantity</th>');
					//row1.append('<th width=200 id="table_searchBookName_bookUnitPrice">bookUnitPrice</th>');
					row1.appendTo(table);	
					$("#table_searchBookName").append("<tbody>");
					
					$(result['data']).each(function(i){
						var rowId="row";
						var table_searchBookName_rangeId="table_searchBookName_rangeId";
						var table_searchBookName_bookId="table_searchBookName_bookId";
						var table_searchBookName_bookName="table_searchBookName_bookName";
						//var table_searchBookName_bookQuantity="table_searchBookName_bookQuantity";
						//var table_searchBookName_bookUnitPrice="table_searchBookName_bookUnitPrice";
						
						table_searchBookName_rangeId=table_searchBookName_rangeId+(i+1);
						table_searchBookName_bookId=table_searchBookName_bookId+(i+1);
						table_searchBookName_bookName=table_searchBookName_bookName+(i+1);
						//table_searchBookName_bookQuantity=table_searchBookName_bookQuantity+(i+1);
						//table_searchBookName_bookUnitPrice=table_searchBookName_bookUnitPrice+(i+1);
						
						var row=$('<tr id="'+rowId+'"></tr>');
						row.append('<td id="'+table_searchBookName_rangeId+'">'+(i+1)+'</td>');
						var a=result['data'][i].bookId;
						row.append('<td id="'+table_searchBookName_bookId+'" onclick="jumpToAnother(this.innerHTML)" onmouseover="mouseover(this)" >'+a+'</td>');//
						var b=result['data'][i].bookName;
						row.append('<td id="'+table_searchBookName_bookName+'">'+b+'</td>');//
						//var c=result['data'][i].bookQuantity;
						//row.append('<td id="'+table_searchBookName_bookQuantity+'">'+c+'</td>');//
						//var d=result['data'][i].bookUnitPrice;
						//row.append('<td id="'+table_searchBookName_bookUnitPrice+'">'+d+'</td>');//
						
						row.appendTo(table);
						rowLength=i+1;
					});
					$("#table_searchBookName").append("</tbody>");
					$("#table_searchBookName").append("</table>");
					document.getElementById("response_searchBookName").innerHTML=rowLength+" records";
					
					
					table.find("tr").hide();
					var num=table.find("tr").length;
					var currentPage=1;//当前页
				    var pageSize=5;//每一页5条记录
				    
				    table.find("tr").hide();
					table.find("tr").slice(0*pageSize,(0+1)*pageSize+1).show();
				    
				    table.bind("paging",function(){
				    	
				    	table.find("tr").hide();
				    	table.find("tr").eq(0).show();
						table.find("tr").slice(currentPage*pageSize+1,(currentPage+1)*pageSize+1).show();
				    });//数据全部隐藏 结合当前页显示数据
				    
					var pageCount=Math.ceil(rowLength/pageSize);//页数
					var page=$('<p id="tablePage"></p>');
					
					$('<a href="#" style="text-decoration: none"><span>[first] </span></a>&nbsp;').bind("click",function(){
		  				$('html, body').animate({scrollTop: $("#notUser").offset().top});
						table.find("tr").hide();
						table.find("tr").eq(0).show();
						table.find("tr").slice(0*pageSize+1,(0+1)*pageSize+1).show();		
					}).appendTo(page);
							
					for(var index=0;index<pageCount;index++)
					{
						$('<a href="#" style="text-decoration: none"><span> ['+(index+1)+'] </span></a>&nbsp;&nbsp;').bind("click",{p:index},function(event){
							currentPage=event.data.p;
							table.trigger("paging");
							$('html, body').animate({scrollTop: $("#notUser").offset().top});
						}).appendTo(page);//触发分页函数
						//$page.append(" ");
					}	
					$('<a href="#" style="text-decoration: none"><span> [before] </span></a>&nbsp;').bind("click",function(){
						
						$('html, body').animate({scrollTop: $("#notUser").offset().top});
						var current=0;
						for(var j=1;j<=rowLength;j++)
						{
							var temp=table.find("tr").slice(j).css('display');
							if(temp!='none')
							{
								current=j;
								break;
							}
						}
						current=Math.ceil((current-1)/pageSize)-1;
						if(current<0)
						{
							alert("this is the first one.");
						}
						else
						{
						table.find("tr").hide();
						table.find("tr").eq(0).show();
						table.find("tr").slice(current*pageSize+1,(current+1)*pageSize+1).show();
						}
					}).appendTo(page);
					
					$('<a href="#" style="text-decoration: none"><span> [next] </span></a>&nbsp;').bind("click",function(){
						$('html, body').animate({scrollTop: $("#notUser").offset().top});
						var current=0;
						for(var j=1;j<=rowLength;j++)
						{
							var temp=table.find("tr").slice(j).css('display');
							if(temp!='none')
							{
								current=j;
								break;
							}
						}
						current=Math.ceil((current-1)/pageSize)+1;
						if(current>=pageCount)
						{
							alert("this page is the last one.");
						}
						else
						{
							table.find("tr").hide();
							table.find("tr").eq(0).show();
							table.find("tr").slice(current*pageSize+1,(current+1)*pageSize+1).show();
						}
					}).appendTo(page);
					$('<a href="#" style="text-decoration: none"><span> [last] </span></a>&ensp;').bind("click",function(){
						$('html, body').animate({scrollTop: $("#notUser").offset().top});
						table.find("tr").hide();
						table.find("tr").eq(0).show();
						table.find("tr").slice((pageCount-1)*pageSize+1,(pageCount)*pageSize+1).show();
					}).appendTo(page);
					page.insertAfter(table);
				}
				},
				error:function(){
					alert("find error.");
				},
			});
	}
	function mouseover(obj){
		var list=$("#searchNameTable").find("td");
		for(var j=0;j<list.length;j++)
		{
			list[j].style="background-color:transparent;";
		}
		obj.style="background-color:#FFBD9D;";
	}
	
	
function jumpToAnother(value){
	//alert(value);
	var url="/test/user/inverseToaBook.do?bookId="+value;
	window.open(url);
}
function searchSeller()
{
	var name=document.getElementById("inputSearch").value;
	name="%"+name+"%";
	$.ajax({
		url: "/test/book/searchSellerDistinct.do",
		type:'POST',
		async:true,
		data:{sellerName:name},
		dataType:'json',
		success:function(result){
			if(result['status']=="0")
			{
				alert(result['errorMsg']);
				document.getElementById("response_searchBookName").innerHTML="0 records";
				document.getElementById("table_searchBookName").innerHTML="";
			}
			else
			{
				var rowLength;
				document.getElementById("table_searchBookName").innerHTML="";
				var table=$('<table border="1" id="tableSellerSearch">');
				table.appendTo($("#table_searchBookName"));
				var row1=$('<tr></tr>');
				row1.append('<th width=200 id="table_searchSeller_rangeId">range</th>');
				row1.append('<th width=200 id="table_searchSeller_sellerName">sellerName</th>');
				row1.appendTo(table);
				$("#table_searchBookName").append("<tbody>");
				
				$(result['data']).each(function(i)
				{
					var rowId="row";
					var table_searchSeller_rangeId="table_searchSeller_rangeId";
					var table_searchSeller_sellerName="table_searchSeller_sellerName";
					
					table_searchSeller_rangeId=table_searchSeller_rangeId+(i+1);
					table_searchSeller_sellerName=table_searchSeller_sellerName+(i+1);
					
					var row=$('<tr id="'+rowId+'"></tr>');
					row.append('<td id="'+table_searchSeller_rangeId+'">'+(i+1)+'</td>');
					var aa=result['data'][i].userName;
					row.append('<td id="'+table_searchSeller_sellerName+'" onclick="searchSellerInformation(this.innerHTML)" onmouseover="mmouseover(this)" >'+aa+'</td>');//
					
					row.appendTo(table);
					rowLength=i+1;
				});
				$("#table_searchBookName").append("</tbody>");
				$("#table_searchBookName").append("</table>");
				document.getElementById("response_searchBookName").innerHTML=rowLength+" records";
				
				table.find("tr").hide();
				var num=table.find("tr").length;
				var currentPage=1;//当前页
			    var pageSize=5;//每一页5条记录
			    
			    table.find("tr").hide();
				table.find("tr").slice(0*pageSize,(0+1)*pageSize+1).show();
			    
			    //每一页调用该函数
				table.bind("paging",function(){  	
			    	table.find("tr").hide();
			    	table.find("tr").eq(0).show();
					table.find("tr").slice(currentPage*pageSize+1,(currentPage+1)*pageSize+1).show();
			    });//数据全部隐藏 结合当前页显示数据
			    
				var pageCount=Math.ceil(rowLength/pageSize);//页数
				var page=$('<p id="tablePage"></p>');
				
				//第一页
				$('<a href="#" style="text-decoration: none"><span>[first] </span></a>&nbsp;').bind("click",function(){
	  				$('html, body').animate({scrollTop: $("#notUser").offset().top});
					table.find("tr").hide();
					table.find("tr").eq(0).show();
					table.find("tr").slice(0*pageSize+1,(0+1)*pageSize+1).show();		
				}).appendTo(page);
						
				//每一页 数字页
				for(var index=0;index<pageCount;index++)
				{
					$('<a href="#" style="text-decoration: none"><span> ['+(index+1)+'] </span></a>&nbsp;&nbsp;').bind("click",{p:index},function(event){
						currentPage=event.data.p;
						table.trigger("paging");
						$('html, body').animate({scrollTop: $("#notUser").offset().top});
					}).appendTo(page);//触发分页函数
					//$page.append(" ");
				}	
				
				//上一页
				$('<a href="#" style="text-decoration: none"><span> [before] </span></a>&nbsp;').bind("click",function(){
					
					$('html, body').animate({scrollTop: $("#notUser").offset().top});
					var current=0;
					for(var j=1;j<=rowLength;j++)
					{
						var temp=table.find("tr").slice(j).css('display');
						if(temp!='none')
						{
							current=j;
							break;
						}
					}
					current=Math.ceil((current-1)/pageSize)-1;
					if(current<0)
					{
						alert("this is the first one.");
					}
					else
					{
					table.find("tr").hide();
					table.find("tr").eq(0).show();
					table.find("tr").slice(current*pageSize+1,(current+1)*pageSize+1).show();
					}
				}).appendTo(page);
				
				//下一页
				$('<a href="#" style="text-decoration: none"><span> [next] </span></a>&nbsp;').bind("click",function(){
					$('html, body').animate({scrollTop: $("#notUser").offset().top});
					var current=0;
					for(var j=1;j<=rowLength;j++)
					{
						var temp=table.find("tr").slice(j).css('display');
						if(temp!='none')
						{
							current=j;
							break;
						}
					}
					current=Math.ceil((current-1)/pageSize)+1;
					if(current>=pageCount)
					{
						alert("this page is the last one.");
					}
					else
					{
						table.find("tr").hide();
						table.find("tr").eq(0).show();
						table.find("tr").slice(current*pageSize+1,(current+1)*pageSize+1).show();
					}
				}).appendTo(page);
				
				//最后一页
				$('<a href="#" style="text-decoration: none"><span> [last] </span></a>&ensp;').bind("click",function(){
					$('html, body').animate({scrollTop: $("#notUser").offset().top});
					table.find("tr").hide();
					table.find("tr").eq(0).show();
					table.find("tr").slice((pageCount-1)*pageSize+1,(pageCount)*pageSize+1).show();
				}).appendTo(page);
				page.insertAfter(table);
			}
		},
		error:function(){
			alert("error");
		}
	});
}
function mmouseover(obj){
	var list=$("#tableSellerSearch").find("td");
	for(var j=0;j<list.length;j++)
	{
		list[j].style="background-color:transparent;";
	}
	obj.style="background-color:#FFBD9D;";
}
function searchSellerInformation(value){
	var url="/test/user/inverseToaUser.do?sellerName="+value;
	window.open(url);
}
</script>

<style>
#secondPart{
position:absolute;
top:100px;
left:80px;
padding-bottom:300px;
}
</style>
<div id="secondPart">
<div class="functionType" id="notUser">
	<div class="function-head" id="function-head">
		<table id="tabone" border="1">
			<tr>
				<th width="200" class="selected">search</th>
				<th width="200" >list</th>
				<th id="typeService1" width="200" onclick="inverseToBook()">sellBook</th>
				<th id="typeService3" width="200" onclick="inverseToDelivery()">delivery</th>
				<th id="typeService3" width="200" onclick="inverseToRefund()">refund</th>
			</tr>
		</table>
	</div>
	<div class="function-content" id="function-content">	
		<div style="display:none;"><p>search & buy <input id="inputSearch" type="text">&nbsp;<button onclick="searchBookName()">search book</button>
				<button onclick="searchSeller()">search seller </button></p><p id="response_searchBookName"></p><p id="table_searchBookName"></p><br/></div>
		<div style="display:none;"><p id="demo">BookList: <p id="createTable"></p> <p id="number_listBooks"></p></div>
		<div></div>
		<div></div>
	</div>
</div></div>
<script type="text/javascript">
$("#tabone").find("th").mouseover(function(){
	var list=$("#tabone").find("th")
	for(var i=0;i<list.length;i++)
	{
		list[i].style="width:200px;";
	}
	this.style="width:200px;"+"background-color:yellow;";
});

var tabs=document.getElementsByClassName("function-head")[0].getElementsByTagName('th');
var t=tabs.length;
var contents = document.getElementsByClassName('function-content')[0].getElementsByTagName('div');
var t2=contents.length; 
tabs[0].onclick = showTab;
tabs[1].onclick = showTab;

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
}

var rowNumber;
document.getElementById("createTable").innerHTML="";
var table=$('<table id="table1"  style="border-top:1px solid #999;border-left:1px solid #999;border-spacing:0;">');
table.appendTo($("#createTable"));
var row1=$('<thead><tr></tr></thead>');
row1.append('<th width="100"  style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">range</th>');
row1.append('<th width="200"  style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">bookId</th>');
row1.append('<th width="200"  style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">bookName</th>');
row1.append('<th width="200"  style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">bookQuantity(a)</th>');
row1.append('<th width="200"  style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">bookUnitPrice(¥)</th>');
row1.appendTo(table);
$.ajax({
	url: "/test/book/booksOnSale.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status']=="0")
		{
			alert(result['errorMsg']);
			document.getElementById("number_listBooks").innerHTML="0  records";
			document.getElementById("createTable").innerHTML="0  records";
		}
		else
		{
			$("#createTable").append("<tbody>");
			$(result['data']).each(function (i){
				var bookId= result['data'][i].bookId;	
				var bookName=result['data'][i].bookName;	
				var bookQuantity=result['data'][i].bookQuantity;
				var bookUnitPrice=result['data'][i].bookUnitPrice;
				var row=$('<tr id="+i+"></tr>');
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">'+(i+1)+'</td>');
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">'+bookId+'</td>');
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">'+bookName+'</td>');
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">'+bookQuantity+'</td>');
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">'+bookUnitPrice+'</td>');
			    row.appendTo(table);
				rowNumber=i+1;
			}); 
			$("#createTable").append("</tbody>");
			$("#createTable").append("</table>");
			document.getElementById("number_listBooks").innerHTML=rowNumber+" records";
			table.find("tr").hide();
			var currentPage=1;//当前页
		    var pageSize=5;//每一页5条记录
		    
		    table.find("tr").hide();
			table.find("tr").slice(0*pageSize+1,(0+1)*pageSize+1).show();
		    
		    table.bind("paging",function(){
		    	
		    	table.find("tr").hide();
				table.find("tr").slice(currentPage*pageSize+1,(currentPage+1)*pageSize+1).show();
		    });//数据全部隐藏 结合当前页显示数据
		    
			var pageCount=Math.ceil(rowNumber/pageSize);//页数
			var page=$('<p id="tablePage"></p>');
			
			$('<a href="#" style="text-decoration: none"><span>[first] </span></a>&nbsp;').bind("click",function(){
  				$('html, body').animate({scrollTop: $("#notUser").offset().top});
				table.find("tr").hide();
				table.find("tr").slice(0*pageSize+1,(0+1)*pageSize+1).show();		
			}).appendTo(page);
					
			for(var index=0;index<pageCount;index++)
			{
				$('<a href="#" style="text-decoration: none"><span> ['+(index+1)+'] </span></a>&nbsp;&nbsp;').bind("click",{p:index},function(event){
					currentPage=event.data.p;
					table.trigger("paging");
					$('html, body').animate({scrollTop: $("#notUser").offset().top});
				}).appendTo(page);//触发分页函数
				//$page.append(" ");
			}	
			$('<a href="#" style="text-decoration: none"><span> [before] </span></a>&nbsp;').bind("click",function(){
				
				$('html, body').animate({scrollTop: $("#notUser").offset().top});
				var current=0;
				for(var j=1;j<=rowNumber;j++)
				{
					var temp=table.find("tr").slice(j).css('display');
					if(temp!='none')
					{
						current=j;
						break;
					}
				}
				current=Math.ceil((current-1)/pageSize)-1;
				if(current<0)
				{
					alert("this is the first one.");
				}
				else
				{
				table.find("tr").hide();
				table.find("tr").slice(current*pageSize+1,(current+1)*pageSize+1).show();
				}
			}).appendTo(page);
			
			$('<a href="#" style="text-decoration: none"><span> [next] </span></a>&nbsp;').bind("click",function(){
				$('html, body').animate({scrollTop: $("#notUser").offset().top});
				var current=0;
				//var temp=$("#tr :hidden");;
				for(var j=1;j<=rowNumber;j++)
				{
					//alert(table.find("tr").slice(j));
					var temp=table.find("tr").slice(j).css('display');
					if(temp!='none')
					{
						current=j;
						break;
					}
				}
				current=Math.ceil((current-1)/pageSize)+1;
				if(current>=pageCount)
				{
					alert("this page is the last one.");
				}
				else
				{
					table.find("tr").hide();
					table.find("tr").slice(current*pageSize+1,(current+1)*pageSize+1).show();
				}
			}).appendTo(page);
			$('<a href="#" style="text-decoration: none"><span> [last] </span></a>&ensp;').bind("click",function(){
				$('html, body').animate({scrollTop: $("#notUser").offset().top});
				table.find("tr").hide();
				table.find("tr").slice((pageCount-1)*pageSize+1,(pageCount)*pageSize+1).show();
			}).appendTo(page);
			page.insertAfter(table);
			//table.trigger("paging");
		}
	},
	error:function(){
		alert('error.');
	}
});
</script>
<p style="color:#FFFFFF; position:fixed;width:50px;height:20px;background-color:red;top:0px;text-align:center;" onclick="showhot()">Hot</p>
<script type="text/javascript">
var show=0;
function showhot(){
	if(show==0)
	{
		$("#bookAdver").show();
		show=1;
	}
	else
	{
		$("#bookAdver").hide();
		show=0;
	}
}
</script>

<style>
#bookAdver{
position:fixed;
width:200px;
height:200px;
background-color:#93FF93;
bottom:0px;
z-index:auto;
display:none;
text-align:center;
}
</style>
<div id="bookAdver">mostSale:<br/>
<p id="bId" onclick="openWeb(this.innerHTML)"></p>
<p id="bName"></p>
<p id="bPrice"></p>
<p id="bSale"></p>
</div>
<script type="text/javascript">
$.ajax({
	url: "/test/book/mostSale.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status']==0)
		{
			alert(result['errorMsg']);
		}
		else
		{
			document.getElementById("bId").innerHTML="bookId: " +result['data'].bookId;
			document.getElementById("bName").innerHTML="bookName: " +result['data'].bookName;
			document.getElementById("bPrice").innerHTML="price: " +result['data'].bookUnitPrice+" ¥";
			document.getElementById("bSale").innerHTML="sale: " +result['data'].sale;
		}
	}
});
function setPosition(){
	$("#bookAdver").css("top","document.documentElement.scrollTop");
}
var time=setInterval("setPosition()", 1000);
function openWeb(value){
	var s=value.split(":");
	var id=s[1].substr(1);
	var url="/test/user/inverseToaBook.do?bookId="+id;
	window.open(url);
}
</script>
	
</body>
</html>




