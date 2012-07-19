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

  $('#main_container').css("height", Math.max($('#tab_content_text').height() + 180, $('#tabs').find('ul').height() + 60, 600));

});
