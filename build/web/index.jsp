<%-- 
    Document   : index
    Created on : Feb 22, 2020, 7:11:25 PM
    Author     : Adarsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload CSV File</title>
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    </head>
    <body>

        <div class="container">
            <div class="row">
                <div class="col m6 offset-m3 offset-s1">
                    <div class="card" style="border-radius: 5px;">
                        <div class="card-content">
                            <h3 style="margin-top: 10px;" class="center-align">Upload CSV !!</h3>
                            <h5 id="msg" class="center-align"></h5>
                            <div class="form center-align">  

                                <br/>
                                <!--//creating form-->

                                <form action="uploadServlet" method="post" id="myForm">
                                    <div class="file-field input-field">
                                        <div class="btn blue">
                                            <span>CHOOSE FILE</span>
                                            <input name="csvfile" type="file">
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text">
                                        </div>
                                    </div><br/>
                                    <button type="submit" class="waves-effect waves-light btn" style="background-color: #1e88e5;">UPLOAD</button>
                                    <a href="showData.jsp" class="waves-effect waves-light btn" style="margin-left: 10px; background-color: #1e88e5;">SHOW DATA</a>
                                </form>
                            </div>
                            <div class="loader center-align" style="margin-top: 12px; display: none;">

                                <div class="preloader-wrapper small active">
                                    <div class="spinner-layer spinner-blue">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-red">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-yellow">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>

                                    <div class="spinner-layer spinner-green">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div><div class="gap-patch">
                                            <div class="circle"></div>
                                        </div><div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>
                                <h6>Please wait...</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>

        <script>
            $(document).ready(function () {
                console.log("page is ready...")

                $("#myForm").on('submit', function (event) {
                    event.preventDefault();     //It prevents to move the server on next page

                    // var f = $(this).serialize();          //it converts data of all text fields into one string but not file type
                    let f = new FormData(this);
                    console.log(f);

                    $(".loader").show();
                    $(".form").hide();

                    $.ajax({
                        url: "uploadServlet",
                        data: f,
                        type: 'POST',

                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            console.log("success...")
                            $(".loader").hide();
                            $(".form").show();
                            if (data.trim() === 'Done')
                            {
                                $("#msg").html("Successfully Registered !!")
                                $("#msg").addClass('green-text')
                            } else
                            {
                                $("#msg").html("Something went wrong on Server !!")
                                $("#msg").addClass('red-text')
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(data);
                            console.log("error...")
                            $(".loader").hide();
                            $(".form").show();
                            $("#msg").html("Something went wrong on Server !!")
                            $("#msg").addClass('red-text')
                        },

                        processData: false,
                        contentType: false,
                    })
                })
            })
        </script>



</html>
