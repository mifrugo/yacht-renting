const removeAlert = () => {
  $(".alert").delay(200, function() {
    $(this).addClass('show');
  });
};

export { removeAlert }
