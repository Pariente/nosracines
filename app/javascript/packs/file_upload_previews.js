
// Start Image Preview
function readURL(input) {
  console.log('readURL function started');
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('#img_prev')
        .attr('src', e.target.result)
        .height(200);
    };

    reader.readAsDataURL(input.files[0]);
  }
}

function checkURLimage(url) {
  return(url.match(/\.(jpeg|jpg|gif|png)$/) != null)
}

function isFileImage(file) {
  const acceptedImageTypes = ['image/gif', 'image/jpeg', 'image/png'];
  return acceptedImageTypes.includes(file['type'])
}

$("#document_document_files_url").change(function(){
  // Clear all previews
  $(".previews div").remove();
  // Renew previews
  for (let i = 0; i < this.files.length; i++) {
    var file  = this.files[i]
    var url   = URL.createObjectURL(file);
    var name  = file.name;
    var img   = new Image();

    console.log(name);
    console.log(isFileImage(file));

    // If file is an image, display it. Else, display default doc pic.
    if (isFileImage(file) == true) {
      img.src = url;
    } else {
      img.src = "https://res.cloudinary.com/flamel/image/upload/v1624120339/default_document_pic.png";
    }

    // Append previews
    $(".previews").append("<div></div>");
    $(".previews").find("div").last().append(img);
    $(".previews").find("div").last().append("<p>" + name + "</p>");
    $(".previews").find("img").addClass("preview_image");
    
    // you can even free these 10bits you occupy in memory if you don't need the url anymore
    img.onload = function() {
      URL.revokeObjectURL(this.src);
    }
  }
});