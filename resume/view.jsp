<!DOCTYPE html>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
     (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	   m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	     })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-47507506-1', 'godong9.com');
    ga('send', 'pageview');

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%
	String jdbcUrl = "jdbc:mysql://localhost:3306/resume";
	String dbId = "root";
	String dbPw = "dmdtka";
	Class.forName("org.mariadb.jdbc.Driver");

	Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
	Statement stmt = conn.createStatement();
	
	session.setAttribute("login_id", "godong9");
	session.setAttribute("login_name", "고동현");
	session.setAttribute("login_nickname", "godong9");
	session.setAttribute("page_status", "resume");

	String id = (String)session.getAttribute("login_id");
	String name = (String)session.getAttribute("login_name");
	String nickname = (String)session.getAttribute("login_nickname");
	String status = (String)session.getAttribute("page_status");

	if(id == null){	//로그인 안된 상태에서 접근할 때 로그인 창으로 이동
	%>
		<script>location.href = "index.html"; </script>
	<%
	}
	
	boolean isEmpty = true;
	String profile = "";
	String image = "";
	String education = "";
	String skills = "";
	String history = "";
	String future = "";
	String history_contents = "";
	ResultSet rs = stmt.executeQuery("SELECT * FROM profile WHERE id='"+id+"';");
	if(rs.next()){
		isEmpty = false;
	}
	else{
		isEmpty = true;
	}
	
	String id_image = id+".jpg";
	if(isEmpty){
		stmt.executeUpdate("INSERT INTO profile (id,contents) VALUES ('"+id+"','');");
		stmt.executeUpdate("INSERT INTO image (id,image) VALUES ('"+id+"','"+id_image+"');");
		stmt.executeUpdate("INSERT INTO education (id,contents) VALUES ('"+id+"','');");
		stmt.executeUpdate("INSERT INTO skills (id,contents) VALUES ('"+id+"','');");
		stmt.executeUpdate("INSERT INTO future (id,contents) VALUES ('"+id+"','');");
	}
	else{
		rs = stmt.executeQuery("SELECT * FROM profile WHERE id='"+id+"';");
		while(rs.next()){
			String tmp_profile = rs.getString("contents");
			profile = tmp_profile;
		}
		rs = stmt.executeQuery("SELECT * FROM image WHERE id='"+id+"';");
		while(rs.next()){
			String tmp_image = rs.getString("image");
			image = tmp_image;
		}
		rs = stmt.executeQuery("SELECT * FROM education WHERE id='"+id+"';");
		while(rs.next()){
			String tmp_education = rs.getString("contents");
			education = tmp_education;
		}
		rs = stmt.executeQuery("SELECT * FROM skills WHERE id='"+id+"';");
		while(rs.next()){
			String tmp_skills = rs.getString("contents");
			skills = tmp_skills;
		}
		rs = stmt.executeQuery("SELECT * FROM future WHERE id='"+id+"';");
		while(rs.next()){
			String tmp_future = rs.getString("contents");
			future = tmp_future;
		}
		rs = stmt.executeQuery("SELECT * FROM history WHERE id='"+id+"' ORDER BY idx DESC;");	
		while(rs.next()){
			String idx = rs.getString("idx");
			String title = rs.getString("title");
			String subtitle = rs.getString("subtitle");
			String term = rs.getString("term");
			String summary = rs.getString("contents");
			String file1 = rs.getString("file1");
			String file2 = rs.getString("file2");
			String file3 = rs.getString("file3");

			summary = StringUtils.replace(summary, "\n", "</br>");

			String tmp_history = "- "+title+" ["+term+"]";
			history += tmp_history+"</br>"; 
			
			String history_idx = "history_"+idx;
			String history_idx_title = history_idx+"_title";
			String history_idx_term = history_idx+"_term";
			String history_idx_subtitle = history_idx+"_subtitle";
			String history_idx_summary = history_idx+"_summary";

			String tmp_tag = "<div class='history_contents_item' id='"+history_idx+"'>";
			tmp_tag += "<div class='history_contents_title'>Title";
			tmp_tag += "<div class='history_contents_form' style='display:inline;' id='"+history_idx_title+"'>"+title+"</div></div>";
			tmp_tag += "<div class='history_contents_title'>Term";
			tmp_tag += "<div class='history_contents_form' style='display:inline;' id='"+history_idx_term+"'>"+"["+term+"]"+"</div></div>";
			tmp_tag += "<div class='history_contents_title'>Subtitle";
			tmp_tag += "<div class='history_contents_form' style='display:inline;' id='"+history_idx_subtitle+"'>"+subtitle+"</div></div>";
			tmp_tag += "<div class='history_contents_title'>Summary</div>";
			tmp_tag += "<div class='history_contents_form' id='"+history_idx_summary+"'>"+summary+"</div>";
			if( file1 != null ){
				if(!file1.equals("null")){
					tmp_tag += "<div class='history_contents_title'>Attached file1";
					tmp_tag += "<a class='history_file_form' href='file/"+id+"_"+title+"_1_"+file1+"'>"+file1+"</a></div>";
				}
			}
			if(file2 != null){
				if(!file2.equals("null")){
					tmp_tag += "<div class='history_contents_title'>Attached file2";
					tmp_tag += "<a class='history_file_form' href='file/"+id+"_"+title+"_2_"+file2+"'>"+file2+"</a></div>";
				}
			}
			if(file3  != null){
				if(!file3.equals("null")){
					tmp_tag += "<div class='history_contents_title'>Attached file3";
					tmp_tag += "<a class='history_file_form' href='file/"+id+"_"+title+"_3_"+file3+"'>"+file3+"</a></div>";
				}
			}
			tmp_tag += "</div>";
			history_contents += tmp_tag;
		}
	}
			
%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="description" content="Resume Management Service">
	<title>Resume</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
<div id="wrapper">
	<header id="main_header">
		<h1>Resume & Experience</h1>
	</header>
	<nav id="main_menu">
		<input id="page_status" type="hidden" value="<%= status %>">
		<ul>
			<li onClick="onClickResume()">Resume</li>
			<li onClick="onClickHistory()">Experience</li>
		</ul>
	</nav>
	<div id="container">

		<div id="page_resume">
			<div id="resume_title"><h1><%= name%>'s Resume</h1>
				<input id="resume_id" type="hidden" value="<%= id %>">
				<div id="image_contents" >
					<img id="profile_img" src="picture/<%= image%>" border="1" width="120" height="160" ><br>
					<form method="POST" enctype="multipart/form-data" action="upload_resume.jsp">
						
					</form>
				</div>	
				<div id="profile" class="profile_form"><h2>Profile</h2>
					<div id="profile_text" class="resume_text_form">
						<%= profile %>
					</div>
					<textarea id="edit_profile" class="resume_text_form" style="display:none;"></textarea>
					<input id="profile_ok" type="button" value="Ok" onClick="editProfileOk()" style="display:none;">
				</div>
			</div>
			<div id="resume_contents">	
				<div id="education" class="resume_form"><h2>Education</h2>
					<div id="education_text" class="resume_text_form">
						<%= education %>
					</div>
					<textarea id="edit_education" class="resume_text_form" style="display:none;"></textarea>
					<input id="education_ok" type="button" value="Ok" onClick="editEducationOk()" style="display:none;">
				</div>
				<div id="skills" class="resume_form"><h2>Skills & Qualifications</h2>
					<div id="skills_text" class="resume_text_form">
						<%= skills %>
					</div>
					<textarea id="edit_skills" class="resume_text_form" style="display:none;"></textarea>
					<input id="skills_ok" type="button" value="Ok" onClick="editSkillsOk()" style="display:none;">
				</div>
				<div id="history" class="resume_form"><h2>Experience</h2>
					<div id="history_text" class="resume_text_form">
						<%= history %>
					</div>
				</div>
			</div>
		</div>

		<div id="page_history" style="display:none;">
			<div id="history_main_title"><h1><%= name%>'s Experience</h1></div>
			<div id="history_contents">
				<%= history_contents %>
			</div>
			
		</div>

	</div>
	<footer id="main_footer">
		Copyright &copy 2013 godong9
	</footer>
	</div>
	<script src="js/jquery-1.10.2.min.js"></script>
	<script src="js/jquery.autosize.min.js"></script>
	<script>
		window.onload = function() {
			var status = $('#page_status').val();
			loadPage(status);
		}

		function loadPage(status){
			status = status.trim();
			if (status == "resume")
			{
				$('#page_resume').show();
				$('#page_history').hide();
				$('#page_future').hide();
			}
			else if (status == "history")
			{
				$('#page_resume').hide();
				$('#page_history').show();
				$('#page_future').hide();
			}
			else if (status == "future")
			{
				$('#page_resume').hide();
				$('#page_history').hide();
				$('#page_future').show();
			}
			else
			{
				console.log(status);
			}
		}

		function onClickResume(){		
			loadPage("resume");
			//alert("Resume");
		}

		function onClickHistory(){		
			loadPage("history");
			//alert("History");
		}

		function onClickFuture(){
			loadPage("future");
			//alert("Future");
		}
		
		function onClickHistoryDelete(idx){
			var history_idx = "history_"+idx;
			$('#'+history_idx).remove();
			
			var url = "delete_history.jsp";
			
			$.ajax({
				url: url,
				type: 'POST',
				data: { idx: idx }, 
				success: function(response, status, request){
					console.log(response);
				}
			});	
		}

		function onClickHistoryModify(idx){
			var history_idx = "history_"+idx;
			var history_title = $('#'+history_idx+'_title');
			var history_title_text = history_title.text();
			var history_term = $('#'+history_idx+'_term');
			var history_term_text = history_term.text();
			var history_subtitle = $('#'+history_idx+'_subtitle');
			var history_subtitle_text = history_subtitle.text();
			var history_summary = $('#'+history_idx+'_summary');
			var history_summary_text = history_summary.text();

			var input_tag = "<input class='history_input_form' id='modify_title' type='text' name='title' value='"+history_title_text+"'>";
			history_title.after(input_tag);
			history_title.remove();

			var input_tag = "<input class='history_input_form' id='modify_term' type='text' name='title' value='"+history_term_text+"'>";
			history_term.after(input_tag);
			history_term.remove();

			var input_tag = "<input class='history_input_form' id='modify_subtitle' type='text' name='title' value='"+history_subtitle_text+"'>";
			history_subtitle.after(input_tag);
			history_subtitle.remove();
			
			var input_tag = "<input class='history_input_form' id='modify_summary' type='text' name='title' value='"+history_summary_text+"'>";
			history_summary.after(input_tag);
			history_summary.remove();
			
			var input_tag = "<button id='complete_btn' onClick='onClickModifyComplete("+idx+")'>완료</button>";
			$('#'+history_idx).append(input_tag);
		}

		function onClickModifyComplete(idx){
			var history_idx = "history_"+idx;
			var history_title_text = $('#modify_title').val();
			var history_term_text = $('#modify_term').val();
			var history_subtitle_text = $('#modify_subtitle').val();
			var history_summary_text = $('#modify_summary').val();

			var url = "edit_history.jsp";
			
			$.ajax({
				url: url,
				type: 'POST',
				data: { idx: idx, title: history_title_text, term: history_term_text, subtitle: history_subtitle_text, summary: history_summary_text  }, 
				success: function(response, status, request){
					window.location.reload();
				}
			});	

		}

		function editProfile(){
			var profile_text = $('#profile_text').text();
			profile_text = profile_text.trim();
			$('#profile_text').hide();
			$('#edit_profile').show();
			$('#edit_profile').autosize();
			$('#profile_ok').show();
			$('#edit_profile').val(profile_text);
		}

		function editProfileOk(){	
			var edit_profile =$("#edit_profile").val().replace(/(\r\n|\n|\n\n)/gi,'[split]');
			edit_profile = edit_profile.replace(/\'/g,"''");
			var array_profile = edit_profile.split("[split]");
			var change_profile="";

			for(var i=0; i<array_profile.length; i++){
				if(array_profile[i]=="")
					change_profile +="<p>&nbsp;</p>"+"\r\n";
				else
					change_profile +="<p>"+array_profile[i]+"</p>"+"\r\n";			
			}
	
			$('#profile_text').empty();
			$('#profile_text').append(change_profile);
			$('#edit_profile').hide();
			$('#profile_ok').hide();
			$('#profile_text').show();
			
			var url = "edit_resume.jsp";
			var type = "profile";
			var id = $('#resume_id').val();
			var contents = change_profile;
			
			$.ajax({
				url: url,
				type: 'POST',
				data: { type: type, id: id, contents: contents }, 
				success: function(response, status, request){
					console.log(response);
				}
			});	
		}

		function editEducation(){
			var education_text = $('#education_text').text();
			education_text = education_text.trim();
			$('#education_text').hide();
			$('#edit_education').show();
			$('#edit_education').autosize();
			$('#education_ok').show();
			$('#edit_education').val(education_text);
		}

		function editEducationOk(){	
			var edit_education =$("#edit_education").val().replace(/(\r\n|\n|\n\n)/gi,'[split]');
			edit_education = edit_education.replace(/\'/g,"''");
			var array_education = edit_education.split("[split]");
			var change_education="";

			for(var i=0; i<array_education.length; i++){
				if(array_education[i]=="")
					change_education +="<p>&nbsp;</p>"+"\r\n";
				else
					change_education +="<p>"+array_education[i]+"</p>"+"\r\n";		
			}
	
			$('#education_text').empty();
			$('#education_text').append(change_education);
			$('#edit_education').hide();
			$('#education_ok').hide();
			$('#education_text').show();
			
			var url = "edit_resume.jsp";
			var type = "education";
			var id = $('#resume_id').val();
			var contents = change_education;
			
			$.ajax({
				url: url,
				type: 'POST',
				data: { type: type, id: id, contents: contents }, 
				success: function(response, status, request){
					console.log(response);
				}
			});	
		}

		function editSkills(){
			var skills_text = $('#skills_text').text();
			skills_text = skills_text.trim();
			$('#skills_text').hide();
			$('#edit_skills').show();
			$('#edit_skills').autosize();
			$('#skills_ok').show();
			$('#edit_skills').val(skills_text);
		}

		function editSkillsOk(){	
			var edit_skills =$("#edit_skills").val().replace(/(\r\n|\n|\n\n)/gi,'[split]');
			edit_skills = edit_skills.replace(/\'/g,"''");
			var array_skills = edit_skills.split("[split]");
			var change_skills="";

			for(var i=0; i<array_skills.length; i++){
				if(array_skills[i]=="")
					change_skills +="<p>&nbsp;</p>"+"\r\n";
				else
					change_skills +="<p>"+array_skills[i]+"</p>"+"\r\n";			
			}
	
			$('#skills_text').empty();
			$('#skills_text').append(change_skills);
			$('#edit_skills').hide();
			$('#skills_ok').hide();
			$('#skills_text').show();
			
			var url = "edit_resume.jsp";
			var type = "skills";
			var id = $('#resume_id').val();
			var contents = change_skills;
			
			$.ajax({
				url: url,
				type: 'POST',
				data: { type: type, id: id, contents: contents }, 
				success: function(response, status, request){
					console.log(response);
				}
			});	
		}

		function editFuture(){
			var future_text = $('#future_text').text();
			future_text = future_text.trim();
			$('#future_text').hide();
			$('#edit_future').show();
			$('#edit_future').autosize();
			$('#future_ok').show();
			$('#edit_future').val(future_text);
		}

		function editFutureOk(){	
			var edit_future =$("#edit_future").val().replace(/(\r\n|\n|\n\n)/gi,'[split]');
			edit_future = edit_future.replace(/\'/g,"''");
			var array_future = edit_future.split("[split]");
			var change_future="";

			for(var i=0; i<array_future.length; i++){
				if(array_future[i]=="")
					change_future +="<p>&nbsp;</p>"+"\r\n";
				else
					change_future +="<p>"+array_future[i]+"</p>"+"\r\n";		
			}
	
			$('#future_text').empty();
			$('#future_text').append(change_future);
			$('#edit_future').hide();
			$('#future_ok').hide();
			$('#future_text').show();
			
			var url = "edit_future.jsp";
			var id = $('#resume_id').val();
			var contents = change_future;
			
			$.ajax({
				url: url,
				type: 'POST',
				data: { id: id, contents: contents }, 
				success: function(response, status, request){
					console.log(response);
				}
			});	
		}

	</script>
</body>
</html>
