#include "lvgl/lvgl.h"
#include "drivers/display/fb/lv_linux_fbdev.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* Macros */
#define FBDEV               ("/dev/fb0")

#define HOR_RES             (1920)
#define VER_RES             (1080)

#define TIMER_PERIOD_MS     (2000)

/* Declarations */
static void _timer_cb(lv_timer_t * p_timer);

/* Static variables */
static lv_display_t *_gp_disp = NULL;

static lv_obj_t * _gp_label = NULL;
static lv_timer_t * _gp_timer = NULL;

int main(void)
{
    /* LVGL init */
    lv_init();

    /* Linux framebuffer device init */
    _gp_disp = lv_linux_fbdev_create();
    lv_linux_fbdev_set_file(_gp_disp, FBDEV);

    /* Set screen background color */
    lv_obj_set_style_bg_color(lv_scr_act(), lv_color_hex(0xD6EDFF), 0);
    lv_obj_set_style_bg_opa(lv_scr_act(), LV_OPA_COVER, 0);

    /* Create a label with empty text */
    _gp_label = lv_label_create(lv_scr_act());
    lv_label_set_text(_gp_label, "");
    lv_obj_set_style_text_color(_gp_label, lv_color_hex(0x6B4226), 0);
    lv_obj_set_style_text_font(_gp_label, &lv_font_montserrat_48, 0);
    lv_obj_align(_gp_label, LV_ALIGN_CENTER, 0, 0);

    /* Create a timer which will periodically switch the texts in the label */
    _gp_timer = lv_timer_create(_timer_cb, TIMER_PERIOD_MS, NULL);
    lv_timer_ready(_gp_timer);

    while (1)
    {
        lv_timer_handler();
        usleep(5000);
    }
}

static void _timer_cb(lv_timer_t * p_timer)
{
    static int8_t _counter = 0;

    switch (_counter)
    {
        case 0:
        lv_label_set_text(_gp_label, "Hello Buildroot!");
        break;

        case 1:
        lv_label_set_text(_gp_label, "I'm an app written ...");
        break;

        case 2:
        lv_label_set_text(_gp_label, "... using the LVGL library");
        break;
    
        default:
        break;
    }

    _counter++;
    if (3 == _counter) _counter = 0;
}
