(function() {
  var preview = document.getElementById('preview');
  var uploader = document.getElementById('fileUpload');
  var reader = new FileReader();

  reader.onloadend = function() {
    preview.src = reader.result;
  }

  uploader.addEventListener('change', function() {
    var file = uploader.files[0];
    if(file) {
      reader.readAsDataURL(file);
    }
    else {
      preview.src = '';
    }
  });
})()
