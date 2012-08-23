$(function() {
  $("#slides").slides({
    play: 5000
  });
  $('#tabs a').add('#storage_tabs a').add('#slide_tabs a').each(function() {
    if (this.href.toLowerCase().split("/")[4]==location.href.toLowerCase().split("/")[4]) {
      $(this).parent().addClass("active_tab");
    }
  });

  $('#navigation a').each(function() {
    if (this.href.toLowerCase().split("/")[3]==location.href.toLowerCase().split("/")[3]) {
      $(this).addClass("selected_nav_link");
    }
  });

  $('#tab_content_container a').each(function() {
    if (this.href.toLowerCase().split("/")[5]==location.href.toLowerCase().split("/")[5]) {
      $(this).addClass("active_content_link");
    }
  });

  $('#main_container').css("height", Math.max($('#tab_content_text').height() + 180, $('#tabs').find('ul').height() + 60, 660));

  $('.remove_feat').click(function(event) {
    event.preventDefault();
    $('#feed_content').toggle();
    if ($('#feed_content').is(":visible")) {
      $(".remove_feat").text("Remove Featured");
    } else {
      $(".remove_feat").text("Add Featured");
    }
  });

  $('.add_brown').click(function(event) {
    event.preventDefault();
    $('.featured').toggleClass('featured_brown'); 
    $('.pagination').toggleClass('pagination_brown');
    $('.slides_container').toggleClass('no_shadow');
    if ($('.featured_brown').is(":visible")) {
      $('.add_brown').text("Remove Brown");
    } else {
      $('.add_brown').text("Add Brown");
    }
  });

  
});
