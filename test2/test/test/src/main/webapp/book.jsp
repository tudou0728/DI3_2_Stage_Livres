<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>

<body style="text-align:center">
<h1 style="text-align:center">SELL Book! </h1>
<style type="text/css">
a
{
position:absolute;
top:30px;
right:50px;
}
li{
float: left;
display:inline;
width: 200px;
height:30px;
border-top:1px solid #999;
border-left:1px solid #999;
border-right:1px solid #999;
}
</style>

<a href="http://localhost:8080/test">homepage</a>
<ul style="text-align:center;width:1000px;margin:0 auto;">
	<li value="1" >add book</li>
	<li value="2" >update book info</li>
	<li value="3" >search book</li>
	<li value="4" >delete book</li>
</ul>
<script type="text/javascript">
var list=document.getElementsByTagName("li");
var list2=document.getElementsByTagName("div");
var nu=list.length;
var style="float: left;display:inline;width: 200px;height:30px;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;";
for(var s=0;s<list.length;s++)
{
	list[s].onclick=show;
}
function show(){
	for(var j=0;j<list2.length;j++)
	{
		list2[j].style="display:none;";
		list[j].style=style;
	}
	if(this.value==1)
	{
		this.style=style+"background-color:yellow;";
		$('#sellBookStyle').show();
	}
	else if(this.value==2)
	{
		this.style=style+"background-color:yellow;";
		$('#updateBookStyle').show();
	}
	else if(this.value==3)
	{
		this.style=style+"background-color:yellow;";
		$('#searchStyle').show();
	}
	else if(this.value==4)
	{
		this.style=style+"background-color:yellow;";
		$('#deleteStyle').show();
	}
}
</script>

<style type="text/css">
#sellBookStyle
{
position:absolute;
top:200px;
text-align: left;
left:400px;
}
</style>
<div id="sellBookStyle" style="display:none;">
	<p>1、add books to sell：</p>
	<p>bookName:<input id="insertBookName" type="text"></p>
	<p>bookQuantity:<input id="insertBookQuantity" type="text"></p>
	<p>bookUnitPrice:<input id="insertBokkUnitPrice" type="text"></p>
	<button onclick="insertBook()">addBook</button>
	<p id="insertBookResponse_book"></p> 
</div>
<script type="text/javascript">
	function insertBook(){
		var r=confirm("verify submit");
		if(r==true)
		{
			$.ajax({
				url:"http://localhost:8080/test/user/verifySession.do",
				type:'GET',
				async:true,
				dataType:'json',
				success:function(result){
					if(result['status']=="0")
					{
						alert(result['errorMsg'])
					}
					else
					{
						var userId=result['userId'];
						var name=document.getElementById("insertBookName").value;
						var quantity=document.getElementById("insertBookQuantity").value;
						var price=document.getElementById("insertBokkUnitPrice").value;
						if(name=="" || quantity=="" || price=="")
						{
							alert("please input information totally.");
						}
						else
						{
							$.ajax
							({
								url:"/test/book/insertBook.do",
								type:'POST',
								data:{bookName:name,bookQuantity:quantity,bookUnitPrice:price,userId:userId},
								dateType:'json',
								async:true,
								success:function(result)
								{
									var hehe=eval("("+result+")");
									//alert(hehe);
									if(hehe['status']!=1)
									{
										//alert(typeof(hehe['errorMsg']));
										alert(hehe['errorMsg']);
									}
									else
									{
										alert(hehe['data']);
										document.getElementById("insertBookResponse_book").innerHTML="bookId:"+hehe['data'];
									}
								},
								error:function()
								{
									alert("error.");
								},
							});
						}
					}
				},
			});
		}
		else
		{
			alert("annuler");
		}
	}
</script>
<br/>
<br/>

<div id="updateBookStyle" style="display:none;">
	<p>2、update information of books</p>
	<p>bookId is:<input type="text" id="updateBookId"></p>
	<p>change bookName to:<input type="text" id="updateBookName"></p>
	<p>change bookQuantity to:<input type="text" id="updateBookQuantity"></p>
	<p>change bookUnitPrice to:<input type="text" id="updateBookUnitPrice"></p> 
	<button onclick="updateBook()">verify</button>
	<p id="response_updateBook"></p>
</div>
<style type="text/css">
#updateBookStyle
{
position:absolute;
top:200px;
text-align: left;
left:400px;
}
</style>
<script type="text/javascript">
function updateBook(){
	var r=confirm("submit verify");
	if(r==true)
	{
	var bookId=document.getElementById("updateBookId").value;
	var bookName=document.getElementById("updateBookName").value;
	var bookQuantity=document.getElementById("updateBookQuantity").value;
	var bookUnitPrice=document.getElementById("updateBookUnitPrice").value;
	if(bookId=="" || bookName=="" || bookQuantity==""|| bookUnitPrice=="")
	{
		alert("please input information totally.");
	}
	else
	{
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'POST',
		async:true,
		dataType:'json',
		success:function(result){
				if(result['status']!="1")
				{
					alert(result['errorMsg'])
				}
				else
				{
					var userId=result['userId'];
					$.ajax({
						url: "/test/book/update.do",
						type:'POST',
						data:{bookId:bookId,bookName:bookName,bookQuantity:bookQuantity,bookUnitPrice:bookUnitPrice,userId:userId},
						async:true,
						dataType:'json',
						success:function(result){			
							alert(result);
							document.getElementById("response_updateBook").innerHTML=result;
							},
						error:function(){
							alert('error.');
						}		
					});
				}
			},
		});
	}
	}
	else
	{
		alert("annuler");
	}
}
</script>
<br/>
<br/>



<div id="searchStyle"style="display:none;"> 
	<p>3、search books:<input id="searchBookName" type="text">
	<button onclick="searchBookName()">searchBookName</button></p>
	<p id="response_searchBookName"></p>
	<p id="table_searchBookName"></p>
	<br/>
	<br/>
</div>
<style type="text/css">
#searchStyle
{
position:absolute;
top:200px;
text-align:left;
left:200px;
}
</style>
<script type="text/javascript">
	function searchBookName(){
	var bookName=document.getElementById("searchBookName").value;
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
					var table=$('<table border="1" >');
					table.appendTo($("#table_searchBookName"));
					var row1=$('<tr></tr>');
					row1.append('<th width=200 id="table_searchBookName_rangeId">range</th>');
					row1.append('<th width=200 id="table_searchBookName_bookId">bookId</th>');
					row1.append('<th width=200 id="table_searchBookName_bookName">bookName</th>');
					row1.append('<th width=200 id="table_searchBookName_bookQuantity">bookQuantity</th>');
					row1.append('<th width=200 id="table_searchBookName_bookUnitPrice">bookUnitPrice</th>');
					row1.appendTo(table);	
					
					$(result['data']).each(function(i){
						var rowId="row";
						var table_searchBookName_rangeId="table_searchBookName_rangeId";
						var table_searchBookName_bookId="table_searchBookName_bookId";
						var table_searchBookName_bookName="table_searchBookName_bookName";
						var table_searchBookName_bookQuantity="table_searchBookName_bookQuantity";
						var table_searchBookName_bookUnitPrice="table_searchBookName_bookUnitPrice";
						
						table_searchBookName_rangeId=table_searchBookName_rangeId+(i+1);
						table_searchBookName_bookId=table_searchBookName_bookId+(i+1);
						table_searchBookName_bookName=table_searchBookName_bookName+(i+1);
						table_searchBookName_bookQuantity=table_searchBookName_bookQuantity+(i+1);
						table_searchBookName_bookUnitPrice=table_searchBookName_bookUnitPrice+(i+1);
						
						var row=$('<tr id="'+rowId+'"></tr>');
						row.append('<td id="'+table_searchBookName_rangeId+'">'+(i+1)+'</td>');
						var a=result['data'][i].bookId;
						row.append('<td id="'+table_searchBookName_bookId+'">'+a+'</td>');//
						var b=result['data'][i].bookName;
						row.append('<td id="'+table_searchBookName_bookName+'">'+b+'</td>');//
						var c=result['data'][i].bookQuantity;
						row.append('<td id="'+table_searchBookName_bookQuantity+'">'+c+'</td>');//
						var d=result['data'][i].bookUnitPrice;
						row.append('<td id="'+table_searchBookName_bookUnitPrice+'">'+d+'</td>');//
						
						row.appendTo(table);
						rowLength=i+1;
					});
					$("#table_searchBookName").append("</table>");
					document.getElementById("response_searchBookName").innerHTML=rowLength+" records";
				}
				},
				error:function(){
					alert("find error.");
				},
			});
	}
</script>
<br/>
<br/>

<div id="deleteStyle"style="width:1024px;display:none;"> 
	<p>4、delete books:bookId:<input id="deleteBook" type="text">
	<button onclick="deleteBook()">delete</button></p>
	<p id="response_deleteBook"></p>
	<br/>
	<br/>
</div>
<style type="text/css">
#deleteStyle
{
position:absolute;
top:200px;
text-align: left;
left:400px;
}
</style>
<script type="text/javascript">
function deleteBook(){
	var bookId=document.getElementById("deleteBook").value;
	var r=confirm("submit");
	if(r==true )
	{
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'POST',
		async:true,
		dataType:'json',
		success:function(result){
				if(result['status']!="1")
				{
					alert(result['errorMsg'])
				}
				else
				{
					var userId=result['userId'];
					$.ajax({
						url:"/test/book/deleteBook.do",
						type:'POST',
						async:true,
						data:{bookId:bookId,userId:userId},
						dataType:'json',
						success:function(result){
							alert(result);
							document.getElementById("response_deleteBook").innerHTML=result;
						}
					});
				}
		}
	});
	}
	else
	{
		alert("annuler successfully.");
		document.getElementById("response_deleteBook").innerHTML="annuler successfully.";
	}
}
</script>
</body>
</html>