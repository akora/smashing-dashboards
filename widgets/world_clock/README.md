# World Clock

![screen shot 2013-11-28 at 12 29 37 pm](https://f.cloud.github.com/assets/412533/1637356/cbb31b16-57e5-11e3-8f73-ca77e1723f32.png)

### Description

A simple widget that's capable of displaying time for multiple locations around the world. In our company([neo](http://www.neo.com/)), we use it to display time in different offices.

### Installation

__1.__ Download [moment.js 2.5.1 from MomentJS](https://raw.github.com/moment/moment/2.5.1/moment.js), 

__2.__ Download [moment-timezone.js 0.0.3 from Moment Timezone](https://raw.github.com/moment/moment-timezone/0.0.3/moment-timezone.js). 

__3.__ Build the timezone data for locations you are interested in: [http://momentjs.com/timezone/data/](http://momentjs.com/timezone/data/) and save the data file as `moment-timezone-data.js`. Note that for the default timezone configuration(shown below in world_clock.cofee) to work, you will need to include timezone data of Asia, America and Europe when building moment-timezone-data.js.

__4.__ Put all the downloaded files in your `/assets/javascripts` directory. 

__5.__ Include them in `application.coffee` __in the following order__:

```
#= require moment.min
#= require moment-timezone.min
#= require moment-timezone-data
```

__6.__ The files `world_clock.coffee`, `world_clock.html` and `world_clock.scss` go in the `/widget/world_clock` directory.

__7.__ Last but not least, add the widget html to your dashboard:

```
<li data-row="1" data-col="1" data-sizex="4" data-sizey="1">
  <div data-view="WorldClock" class="widget widget-world-clock"></div>
</li>
```
