# slick-template
A template engine that mimics the syntax from Ruby's Slim language


#### Example Template


```slim
doctype strict

html
  head
    title My HTML title

    stylesheet src='/some.css'

    javascript:
      console.log('embedded JS inside the template');

  body
    css:
      .alert { color: 'red'; }

    .menu-bar
      - if user.logged_in
        img src={user.profile.image_path}
      - else
        a#login-button.btn.btn-primary href={login_path} Login

    .alert
      h1 {greeting}

    p.exciting This is the first ever Elixir Slick Template

    h2#member-list Members

    form
      input type='checkbox' disabled=True checked=True

    p
      ul
        - for user in users
          li
            / code comment - show the user's names. This line will not render.
            span {user.first_name} {user.last_name}
    /! render the footer
    #footer Thanks for using Slick!
```

#### Rendered HTML

Trim-Template will render the above template into HTML, as below:

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
    <head>
        <title>My HTML title</title>

        <stylesheet src="/some.css"></stylesheet>

        <script type='javascript'>
            console.log('embedded JS inside the template');
        </script>
    </head>

    <body>
        <style>
          .alert { color: 'red'; }
        </style>

        <div class="menu-bar">
            <a class="btn btn-primary" href="/auth/login" id="login-button"/>Login</a>
        </div>

        <div class="alert">
            <h1>Hello World!</h1>
        </div>

        <p class="exciting">
            This is the first ever Elixir Slick Template
        </p>

        <h2 id='member-list'>Members</h2>

        <form>
          <input type="checkbox" disabled="disabled" checked="checked"/>
        </form>

        <p>
            <ul>
                <li>
                    <span>Stephen Colbert</span>
                </li>
                <li>
                    <span>Bob Marley</span>
                </li>
                <li>
                    <span>Charlie Chaplin</span>
                </li>
            </ul>
        </p>
        <!-- render the footer -->
        <div id='footer'>Thanks for using Slick!</div>
    </body>
</html>
```

