<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<head>
<title>seller information</title>
</head>
<body>
<h1>seller information</h1>
<br/>
<br/>
<ul>
	<li value=1 style="text-align:center;width:500px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;">books on sale</li>
	<li value=2 style="text-align:center;width:500px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;">books not sale</li>
</ul>
<script type="text/javascript">
var list=document.getElementsByTagName("li");
var list2=document.getElementsByTagName("div");
var style1="text-align:center;width:500px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;";
//var style2="text-align:center;width:500px;float:left;display:inline;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;";
for(var i=0;i<list.length;i++)
{
	list[i].onclick=show;
}
function show(){
	list[0].style=list[1].style=style1;
	for(var j=0;j<list2.length;j++)
	{
		list2[j].style="display:none;";
	}
	if(this.value==1)
	{
		this.style=style1+"background-color:yellow;";
		$('#sellerInformation').show();
	}
	if(this.value==2)
	{
		this.style=style1+"background-color:yellow;";
		$('#sellerInformation2').show();
	}
}
</script>

<style>
#sellerInformation
{
position:absolute;
top:200px;
left:25px;
display:none;
}
#sellerInformation2
{
position:absolute;
top:200px;
left:25px;
display:none;
}
</style>
<div id="sellerInformation">seller information --- books on sale:
<p id="response"></p>
</div>
<br/>
<br/>

<div id="sellerInformation2">seller information --- books not sale:
<p id="response2"></p>
</div>
<script type="text/javascript">
var sellerName=window.location.href.split("=")[1];
$.ajax({
	url:"/test/book/searchSeller.do",
	type:"POST",
	data:{sellerName:sellerName},
	dataType:'json',
	async:true,
	success:function(result)
	{
		if(result['status1']=='0')
		{
			//alert(result['errorMsg']);
			document.getElementById("response").innerHTML="0 records";
		}
		else
		{
			var rowLength;
			var table=$('<table border="1">');
			table.appendTo($("#sellerInformation"));
			var row1=$('<tr></tr>');
			row1.append('<th width=100 id="sellerInformation_rangeId">range</th>');
			row1.append('<th width=200 id="sellerInformation_sellerName">sellerName</th>');
			row1.append('<th width=200 id="sellerInformation_bookId">bookId</th>');
			row1.append('<th width=200 id="sellerInformation_bookName">bookName</th>');
			row1.append('<th width=200 id="sellerInformation_bookQuantity">bookQuantity</th>');
			row1.append('<th width=200 id="sellerInformation_bookUnitPrice">bookUnitPrice</th>');
			row1.append('<th width=200 id="sellerInformation_bookSale">bookSale</th>');
			row1.appendTo(table);
			
			$(result['booksOnSale']).each(function(i){
				var rowId="row";
				var sellerInformation_rangeId="sellerInformation_rangeId";
				var sellerInformation_sellerName="sellerInformation_sellerName";
				var sellerInformation_bookId="sellerInformation_bookId";
				var sellerInformation_bookName="sellerInformation_bookName";
				var sellerInformation_bookQuantity="sellerInformation_bookQuantity";
				var sellerInformation_bookUnitPrice="sellerInformation_bookUnitPrice";
				var sellerInformation_bookSale="sellerInformation_bookSale";
				
				sellerInformation_rangeId=sellerInformation_rangeId+(i+1);
				sellerInformation_sellerName=sellerInformation_sellerName+(i+1);
				sellerInformation_bookId=sellerInformation_bookId+(i+1);
				sellerInformation_bookName=sellerInformation_bookName+(i+1);
				sellerInformation_bookQuantity=sellerInformation_bookQuantity+(i+1);
				sellerInformation_bookUnitPrice=sellerInformation_bookUnitPrice+(i+1);
				sellerInformation_bookSale=sellerInformation_bookSale+(i+1);
				
				var row=$('<tr id="'+rowId+'"></tr>');
				row.append('<td id="'+sellerInformation_rangeId+'">'+(i+1)+'</td>');
				row.append('<td id="'+sellerInformation_sellerName+'">'+sellerName+'</td>');//
				var a=result['booksOnSale'][i].bookId;
				row.append('<td id="'+sellerInformation_bookId+'" onclick="bookInformation(this.innerHTML)">'+a+'</td>');//
				var b=result['booksOnSale'][i].bookName;
				row.append('<td id="'+sellerInformation_bookName+'">'+b+'</td>');//
				var c=result['booksOnSale'][i].bookQuantity;
				row.append('<td id="'+sellerInformation_bookQuantity+'">'+c+'</td>');//
				var d=result['booksOnSale'][i].bookUnitPrice;
				row.append('<td id="'+sellerInformation_bookUnitPrice+'">'+d+'</td>');//
				var e=result['booksOnSale'][i].sale;
				row.append('<td id="'+sellerInformation_bookSale+'">'+e+'</td>');
				
				row.appendTo(table);
				rowLength=i+1;
			});
			$("#sellerInformation").append("</table>");
			document.getElementById("response").innerHTML=rowLength+" records";	
		}
		if(result['status2']=='0')
		{
			//alert(result['errorMsg']);
			document.getElementById("response2").innerHTML="0 records";
		}
		else
		{
			var rowLength;
			var table=$('<table border="1">');
			table.appendTo($("#sellerInformation2"));
			var row1=$('<tr></tr>');
			row1.append('<th width=100 id="sellerInformation_rangeId">range</th>');
			row1.append('<th width=200 id="sellerInformation_sellerName">sellerName</th>');
			row1.append('<th width=200 id="sellerInformation_bookId">bookId</th>');
			row1.append('<th width=200 id="sellerInformation_bookName">bookName</th>');
			row1.append('<th width=200 id="sellerInformation_bookQuantity">bookQuantity</th>');
			row1.append('<th width=200 id="sellerInformation_bookUnitPrice">bookUnitPrice</th>');
			row1.append('<th width=200 id="sellerInformation_bookSale">bookSale</th>');
			row1.appendTo(table);
			
			$(result['booksNotSale']).each(function(i){
				var rowId="row";
				var sellerInformation_rangeId="sellerInformation_rangeId";
				var sellerInformation_sellerName="sellerInformation_sellerName";
				var sellerInformation_bookId="sellerInformation_bookId";
				var sellerInformation_bookName="sellerInformation_bookName";
				var sellerInformation_bookQuantity="sellerInformation_bookQuantity";
				var sellerInformation_bookUnitPrice="sellerInformation_bookUnitPrice";
				var sellerInformation_bookSale="sellerInformation_bookSale";
				
				sellerInformation_rangeId=sellerInformation_rangeId+(i+1);
				sellerInformation_sellerName=sellerInformation_sellerName+(i+1);
				sellerInformation_bookId=sellerInformation_bookId+(i+1);
				sellerInformation_bookName=sellerInformation_bookName+(i+1);
				sellerInformation_bookQuantity=sellerInformation_bookQuantity+(i+1);
				sellerInformation_bookUnitPrice=sellerInformation_bookUnitPrice+(i+1);
				sellerInformation_bookSale=sellerInformation_bookSale+(i+1);
				
				var row=$('<tr id="'+rowId+'"></tr>');
				row.append('<td id="'+sellerInformation_rangeId+'">'+(i+1)+'</td>');
				row.append('<td id="'+sellerInformation_sellerName+'">'+sellerName+'</td>');//
				var a=result['booksNotSale'][i].bookId;
				row.append('<td id="'+sellerInformation_bookId+'">'+a+'</td>');//
				var b=result['booksNotSale'][i].bookName;
				row.append('<td id="'+sellerInformation_bookName+'">'+b+'</td>');//
				var c=result['booksNotSale'][i].bookQuantity;
				row.append('<td id="'+sellerInformation_bookQuantity+'">'+c+'</td>');//
				var d=result['booksNotSale'][i].bookUnitPrice;
				row.append('<td id="'+sellerInformation_bookUnitPrice+'">'+d+'</td>');//
				var e=result['booksNotSale'][i].sale;
				row.append('<td id="'+sellerInformation_bookSale+'">'+e+'</td>');
				
				row.appendTo(table);
				rowLength=i+1;
			});
			$("#sellerInformation2").append("</table>");
			document.getElementById("response2").innerHTML=rowLength+" records";	
		}
	},
	error:function(){
		alert("find error.");
	}
});

function  bookInformation(value){
	//alert(value);
	var url="/test/user/inverseToaBook.do?bookId="+value;
	window.open(url);
}
</script>

</body>
</html>