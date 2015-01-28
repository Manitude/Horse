  $(document).ready(function() {
    
    $('*[class^="th"]').each(function(index, obj){
        createWidth(obj.className, obj.className.substring(2, obj.className.length));
    });
  });
  
  function createWidth(nameOfClass, width){
    $('.'+nameOfClass).css({'width': width+'%', 'word-wrap': 'break-word'});
  }
  