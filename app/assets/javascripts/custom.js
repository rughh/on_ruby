function showHide() {
  $(".toggle").click(function(event) {
    event.preventDefault();
    const name = $(this).attr("name");
    $(`.toggle_${name}`).slideToggle();
  });
}

function displayUsers() {
  const func = () =>
    jQuery.each($(".imagelist img[data-src]:visible"), function() {
      const src = $(this).attr("src");
      const dataSrc = $(this).attr("data-src");
      $(this).removeAttr("data-src");
      if (src !== dataSrc) {
        const img = new Image();
        img.onload = () => $(this).attr("src", dataSrc);
        return img.src = dataSrc;
      }
    })
  ;
  setInterval(func, 500);
}

function close() {
  $(".close").click(function(event) {
    event.preventDefault();
    $(this).parent().fadeOut();
  });
}

function jobs() {
  if ($('#job-list .job').size() > 1) {
    $('.job-toggle a').on('click', function(event) {
      event.preventDefault();
      $("#job-teaser").toggle();
      $("#job-list").toggle();
    });

    const func = () =>
      $('#job-teaser .job').animate({opacity: 0.5}, 1000, () => $('#job-teaser .job').replaceWith($('#job-list .job').random().clone()))
    ;
    setInterval(func, 5000);
  }
}

function moreList() {
  Array.from($("ul.more-list")).map((list) =>
    (function(list) {
      const preview_size = $(list).data('preview-size') || 4;
      const elements = $(list).find("li");
      if (elements.size() > preview_size) {
        elements.slice(preview_size).hide();
        const link = $(`<i class='fa fa-chevron-down'></i> <a class='more' href='#'>${I18n.showMore}</a>`);
        const container = $("<p></p>").append(link);
        container.insertAfter(list);
        return link.click(function(event) {
          event.preventDefault();
          link.hide();
          elements.filter(":hidden").fadeIn();
        });
      }
    })(list));
}


$(function() {
  jobs();
  close();
  showHide();
  moreList();
  displayUsers();

  $('.collapser').collapser({
  	mode: 'words',
  	truncate: 20,
  	showText: '>>',
  	hideText: '<<',
  });
});
