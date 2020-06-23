# Life tutorial

Game of Life implementation tutorial from <https://simplegametutorials.github.io/life/>

Problem is that the refresh draw is very heavy - 60%+ CPU usage just for the love process because it redraws every frame on every tick

I took the loop function from <https://love2d.org/wiki/love.run> which is the normal main loop, and added a check for a variable. In the game itself I added the variable so that it would only trigger the clear+redraw after a certain time. This brought the CPU usage down to 20% which is certainly better, but it means that the redraw loop seems to be a very heavy item...

On the other tutorial I checked the usage - it listens for interaction events constantly (without the mitigation I spec'd above), and there is a detailed background image. If I hold down the mouse, it causes stamps to appear at the same rate as the refresh rate, creating a large array of a single image to be redrawn over-and-over. (current state at commit `e96637b`)

However, it uses hardly any CPU for this. I am thinking of further refactoring the Life example to minimize a number of dereferences to cmopare its effect on CPU usage
