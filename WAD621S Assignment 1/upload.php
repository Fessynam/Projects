<?php
    $FileName=$_FILES['fuResume']['name'];
    $TmName=$_FILES['fuResume']['tmp_name'];

    move_uploaded_file($TmpName,$FileName);

    echo("File uploaded Sucessfuly");

?>