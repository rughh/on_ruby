/*
 * decaffeinate suggestions:
 * DS101: Remove unnecessary use of Array.from
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
const OnRuby = {
  showHide() {
    return $(".toggle").click(function(event) {
      event.preventDefault();
      const name = $(this).attr("name");
      return $(`.toggle_${name}`).slideToggle();
    });
  },

  displayUsers() {
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
    return setInterval(func, 500);
  },

  close() {
    return $(".close").click(function(event) {
      event.preventDefault();
      return $(this).parent().fadeOut();
    });
  },

  jobs() {
    if ($('#job-list .job').size() > 1) {
      $('.job-toggle a').on('click', function(event) {
        event.preventDefault();
        $("#job-teaser").toggle();
        return $("#job-list").toggle();
      });

      const func = () =>
        $('#job-teaser .job').animate({opacity: 0.5}, 1000, () => $('#job-teaser .job').replaceWith($('#job-list .job').random().clone()))
      ;
      return setInterval(func, 5000);
    }
  },

  moreList() {
    return Array.from($("ul.more-list")).map((list) =>
      (function(list) {
        const preview_size = $(list).data('preview-size') || 4;
        const elements = $(list).find("li");
        if (elements.size() > preview_size) {
          elements.slice(preview_size).hide();
          const link = $(`<i class='fa fa-chevron-down pull-left'></i><a class='more' href='#'>${I18n.showMore}</a>`);
          const container = $("<p></p>").append(link);
          container.insertAfter(list);
          return link.click(function(event) {
            event.preventDefault();
            link.hide();
            return elements.filter(":hidden").fadeIn();
          });
        }
      })(list));
  }
};

$(function() {
  OnRuby.jobs();
  OnRuby.close();
  OnRuby.showHide();
  OnRuby.moreList();
  return OnRuby.displayUsers();
});
