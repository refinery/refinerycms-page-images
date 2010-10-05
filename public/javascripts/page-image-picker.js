$(document).ready(function(){
  $('a[href*=page_image_picker]').click(function(){
    if (!(picker = $('#page_image_picker')).data('size-applied')){
      wym_box = $('.page_part:first .wym_box');
      iframe = $('.page_part:first iframe');
      picker.css({
        height: wym_box.height()
        , width: wym_box.width()
      }).data('size-applied', true).corner('tr 5px').corner('bottom 5px').find('.wym_box').css({
        backgroundColor: 'white'
        , height: iframe.height() + $('.page_part:first .wym_area_top').height() - parseInt($('.wym_area_top .label_inline_with_link a').css('lineHeight'))
        , width: iframe.width() - 20
        , 'border-color': iframe.css('border-top-color')
        , 'border-style': iframe.css('border-top-style')
        , 'border-width': iframe.css('border-top-width')
        , padding: '0px 10px 0px 10px'
      });
    }
  });
});

reset_functionality = function() {
  $("#page_images").sortable({
    'tolerance': 'pointer'
    , 'placeholder': 'placeholder'
    , 'cursor': 'drag'
    , 'items': 'li'
    , stop: reindex_images
  });

  $('#content #page_images li:not(.empty)').each(function(index, li) {
    $(this).hover(function(e){
      if ((image_actions = $(this).find('.image_actions')).length == 0) {
        image_actions = $("<div class='image_actions'></div>");
        img_delete = $("<img src='/images/refinery/icons/delete.png' width='16' height='16' />");
        img_delete.appendTo(image_actions);
        img_delete.click(function() {
          $(this).parents('li[id*=image_]').remove();
          reindex_images();
        });

        image_actions.appendTo($(li));
      }

      image_actions.show();
    }, function(e) {
      $(this).find('.image_actions').hide();
    });
  });

  reindex_images();
}



image_added = function(image) {
  last_portfolio_entry_image_id = "";
  new_list_item = (current_list_item = $('li.empty')).clone();
  image_id = $(image).attr('id').replace('image_', '');
  current_list_item.find('input:hidden').val(image_id);
  $.ajax({
    async: false,
    url: '/refinery/images/'+image_id+'/url',
    data: {size: '135x135#c'},
    success: function (result, status, xhr) {
      if (result.error) {
        if (console && console.log) {
           console.log("Something went wrong with the image insertion!");
           console.log(result);
         }
       } else {
         (img = $("<img />")).attr({
           title: $(image).attr('title')
           , alt: $(image).attr('alt')
           , src: result.url
         }).appendTo(current_list_item);
       }
     },
     error: function(xhr, txt, status) {
       if (console && console.log) {
         console.log("Something went wrong with the image insertion!");
         console.log(xhr);
         console.log(txt);
         console.log(status);
       }
     }
   });

  current_list_item.attr('id', 'image_' + image_id).removeClass('empty');

  new_list_item.appendTo($('#page_images'));
  reset_functionality();
}