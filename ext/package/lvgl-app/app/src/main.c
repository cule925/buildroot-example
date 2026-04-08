#include "lvgl/lvgl.h"
#include "drivers/display/fb/lv_linux_fbdev.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* Macros */
#define FBDEV                       ("/dev/fb0")

#define HOR_RES                     (1920)
#define VER_RES                     (1080)

#define TEXT_TIMER_PERIOD_MS        (2000)
#define ANIMATION_TIMER_PERIOD_MS   (20)

#define CIRCLE_X_POS_MIN            (-300)
#define CIRCLE_X_POS_MAX            (300)

#define CIRCLE_UPPER_Y_POS          (-150)
#define CIRCLE_LOWER_Y_POS          (150)

/* Declarations */
static void _text_timer_cb(lv_timer_t * p_timer);
static void _animation_timer_cb(lv_timer_t * p_timer);

/* Static variables */
static lv_display_t *_gp_disp = NULL;

static lv_obj_t * _gp_label = NULL;
static lv_obj_t * _gp_circle_lower = NULL;
static lv_obj_t * _gp_circle_upper = NULL;
static lv_timer_t * _gp_text_timer = NULL;
static lv_timer_t * _gp_animation_timer = NULL;

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
    lv_obj_set_style_text_font(_gp_label, &lv_font_montserrat_36, 0);
    lv_obj_align(_gp_label, LV_ALIGN_CENTER, 0, 0);

    /* Create circles */
    _gp_circle_lower = lv_obj_create(lv_scr_act());
    lv_obj_set_size(_gp_circle_lower, 50, 50);
    lv_obj_set_style_radius(_gp_circle_lower, LV_RADIUS_CIRCLE, 0);
    lv_obj_set_style_bg_color(_gp_circle_lower, lv_color_hex(0x6B4226), 0);
    lv_obj_set_style_bg_opa(_gp_circle_lower, LV_OPA_COVER, 0);
    lv_obj_align(_gp_circle_lower, LV_ALIGN_CENTER, CIRCLE_X_POS_MIN, CIRCLE_LOWER_Y_POS);

    _gp_circle_upper = lv_obj_create(lv_scr_act());
    lv_obj_set_size(_gp_circle_upper, 50, 50);
    lv_obj_set_style_radius(_gp_circle_upper, LV_RADIUS_CIRCLE, 0);
    lv_obj_set_style_bg_color(_gp_circle_upper, lv_color_hex(0x6B4226), 0);
    lv_obj_set_style_bg_opa(_gp_circle_upper, LV_OPA_COVER, 0);
    lv_obj_align(_gp_circle_upper, LV_ALIGN_CENTER, CIRCLE_X_POS_MAX, CIRCLE_UPPER_Y_POS);

    /* Create a timer which will periodically switch the texts in the label */
    _gp_text_timer = lv_timer_create(_text_timer_cb, TEXT_TIMER_PERIOD_MS, NULL);
    lv_timer_ready(_gp_text_timer);

    /* Create a timer which will move the circles */
    _gp_animation_timer = lv_timer_create(_animation_timer_cb, ANIMATION_TIMER_PERIOD_MS, NULL);

    while (1)
    {
        lv_timer_handler();
        usleep(5000);
    }
}

static void _text_timer_cb(lv_timer_t * p_timer)
{
    static int8_t _counter = 0;

    switch (_counter)
    {
        case 0:
        lv_label_set_text(_gp_label, "Hello from Buildroot!");
        break;

        case 1:
        lv_label_set_text(_gp_label, "This is a graphical app ...");
        break;

        case 2:
        lv_label_set_text(_gp_label, "... built using the LVGL library");
        break;
    
        default:
        break;
    }

    _counter++;
    if (3 == _counter) _counter = 0;
}

static void _animation_timer_cb(lv_timer_t * p_timer)
{
    static int _circle_lower_x_pos = CIRCLE_X_POS_MIN;
    static int _circle_lower_dx = 5;
    static int _circle_upper_x_pos = CIRCLE_X_POS_MAX;
    static int _circle_upper_dx = 5;

    /* Move the lower and upper circles back and forth */
    _circle_lower_x_pos += _circle_lower_dx;
    if (_circle_lower_x_pos > CIRCLE_X_POS_MAX || _circle_lower_x_pos < CIRCLE_X_POS_MIN) _circle_lower_dx = -_circle_lower_dx;
    lv_obj_align(_gp_circle_lower, LV_ALIGN_CENTER, _circle_lower_x_pos, CIRCLE_LOWER_Y_POS);
    _circle_upper_x_pos += _circle_upper_dx;
    if (_circle_upper_x_pos > CIRCLE_X_POS_MAX || _circle_upper_x_pos < CIRCLE_X_POS_MIN) _circle_upper_dx = -_circle_upper_dx;
    lv_obj_align(_gp_circle_upper, LV_ALIGN_CENTER, _circle_upper_x_pos, CIRCLE_UPPER_Y_POS);
}
