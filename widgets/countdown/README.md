## Description

Simple [Dashing](http://shopify.github.com/dashing) widget to countdown until a certain moment.
Flashes the widget when finished.

##Usage

To use this widget, copy `countdown.html`, `countdown.coffee`, and `countdown.scss` into the `/widgets/countdown` directory.

To include the widget in a dashboard, add the following snippet to the dashboard layout file:

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-view="Countdown" data-title="GOAL_DISPLAY_NAME" data-end="26-Apr-2013 18:00:00"></div>
    </li>

##Preview

![](http://s13.postimg.org/zc1c0wvbb/countdown.png)