/************************/
/* periscope2 basic JS  */
/************************/
// Control busy indicator div in the header
setInterval(function() {
    if ($('html').attr('class')=='shiny-busy') {
        busyTimeout = setTimeout(function() {
            if ($('html').attr('class')=='shiny-busy') {
                $('div.periscope-busy-ind').css('display', 'inline-flex');
                $('div.periscope-busy-ind').fadeIn(500);
            }
        }, 250);
    } else {
        if (typeof busyTimeout !== 'undefined') {
            clearTimeout(busyTimeout);
        }

        $('div.periscope-busy-ind').hide();
    }
}, 100);


// Resolve bs4Dash alert title and close button issues
Shiny.addCustomMessageHandler('pcreate-alert', function (message) {
    // setup target
    var alertTarget;
    var id = '';

    if (message.id) {
        id          = message.id;
        alertTarget = `#${message.id}`;
    } else if (message.selector) {
        id          = message.selector.replace(/#|\./g, '');
        alertTarget = message.selector;
    }

    // build the tag from options
    var config = message.options, alertCl, alertTag, iconType, closeButton, titleTag, contentTag;

    alertCl = 'alert alert-dismissible';
    if (config.status !== undefined) {
      alertCl = `${alertCl} alert-${config.status}`;
    }

    if (config.elevation !== undefined) {
      alertCl = `${alertCl} elevation-${config.elevation}`;
    }

    switch (config.status) {
      case 'primary': iconType = 'info';
        break;
      case 'danger': iconType = 'ban';
        break;
      case 'info': iconType = 'info';
        break;
      case 'warning': iconType = 'warning';
        break;
      case 'success': iconType = 'check';
        break;
      default: console.warn(`${config.status} does not belong to allowed statuses!`)
    }

    closeButton = '';

    if (config.closable) {
      closeButton = '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>'
    }

    title = config.title;

    if (title) {
        contentTag = `<h5><i class="icon fa fa-${iconType}"></i>${config.content}</h5>`

        alertTag = `<div
            id="${id}-alert"
            class="${alertCl}">
            ${closeButton}${contentTag}
            </div>`
    } else {
        titleTag = `<h5><i class="icon fa fa-${iconType}"></i>${title}</h5>`
        contentTag = config.content;

        alertTag = `<div
            id="${id}-alert"
            class="${alertCl}">
            ${closeButton}${titleTag}${contentTag}
            </div>`
    }

    if (config.width !== undefined) {
      alertTag = `<div class="col-sm-${config.width}">${alertTag}</div>`
    }

    // add it to the DOM if no existing alert is found in the anchor
    if ($(`#${message.id}-alert`).length === 0) {
      $(alertTarget).append(alertTag);
      Shiny.setInputValue(message.id, true, { priority: 'event' });

      // add events only after element is inserted

      // callback -> give ability to perform more actions on the Shiny side
      // once the alert is closed
      $(`#${message.id}-alert`).on('closed.bs.alert', function () {
        Shiny.setInputValue(message.id, false, { priority: 'event' });
      });
      // Clicking on close button does not trigger any event.
      // Trigger the closed.bs.alert event.
      $('[data-dismiss="alert"]').on('click', function () {
        var alertId = $(this).parent.attr('id');
        $(`#${alertId}.`).trigger('closed.bs.alert');
      });

    } else {
      console.warn(`${alertTarget} already has an alert!`);
    }
});

jQuery(document).ready(function() {
    setTimeout(function() {
        $('.waiter-overlay').remove();
    }, 3000);
});

/* END of periscope2 basic JS*/
