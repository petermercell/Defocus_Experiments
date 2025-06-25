// FocusGradient.cpp - Nuke C++ Plugin
// 3 independent moveable areas with pure zones and intersection gradients

#include "DDImage/Iop.h"
#include "DDImage/Row.h"
#include "DDImage/Tile.h"
#include "DDImage/Knobs.h"
#include "DDImage/DDMath.h"
#include <cmath>

using namespace DD::Image;

class FocusGradient : public Iop
{
    // Parameters
    float near_focus_;
    float focus_plane_;
    float far_focus_;
    float near_position_;
    float focus_position_;
    float far_position_;
    float near_pure_size_;
    float focus_pure_size_;
    float far_pure_size_;
    float rotation_;
    bool invert_;
    
    // Cached rotation values
    float cos_rot_, sin_rot_;
    float img_center_x_, img_center_y_;

public:
    FocusGradient(Node* node) : Iop(node)
    {
        // Default values
        near_focus_ = 0.5f;
        focus_plane_ = 1.0f;
        far_focus_ = 5.0f;
        near_position_ = 0.2f;
        focus_position_ = 0.5f;
        far_position_ = 0.2f;
        near_pure_size_ = 10.0f;
        focus_pure_size_ = 10.0f;
        far_pure_size_ = 10.0f;
        rotation_ = 0.0f;
        invert_ = false;
    }

    // Static create function
    static Iop* create(Node* node) { return new FocusGradient(node); }

    void _validate(bool for_real) override
    {
        // Copy input format to output
        copy_info();
        
        // Calculate rotation values
        float rad = rotation_ * M_PI / 180.0f;
        cos_rot_ = cos(rad);
        sin_rot_ = sin(rad);
        
        // Calculate image center
        img_center_x_ = info_.w() * 0.5f;
        img_center_y_ = info_.h() * 0.5f;
    }

    void _request(int x, int y, int r, int t, ChannelMask channels, int count) override
    {
        // Request the same region from input
        input0().request(x, y, r, t, channels, count);
    }

    void engine(int y, int x, int r, ChannelMask channels, Row& row) override
    {
        // Get input row
        Row input_row(x, r);
        input0().get(y, x, r, channels, input_row);
        
        float img_height = info_.h();
        
        foreach(z, channels) {
            const float* input_ptr = input_row[z] + x;
            float* output_ptr = row.writable(z) + x;
            
            for (int px = x; px < r; px++) {
                float gradient_value = calculate_gradient_value(px, y, img_height);
                output_ptr[px - x] = gradient_value;
            }
        }
    }

private:
    float calculate_gradient_value(int x, int y, float img_height)
    {
        float pos_x = float(x);
        float pos_y = float(y);
        
        // Apply rotation around image center
        float diff_x = pos_x - img_center_x_;
        float diff_y = pos_y - img_center_y_;
        float rotated_x = diff_x * cos_rot_ - diff_y * sin_rot_;
        float rotated_y = diff_x * sin_rot_ + diff_y * cos_rot_;
        float pixel_y = rotated_y + img_center_y_;
        
        if (invert_) {
            pixel_y = img_height - pixel_y;
        }
        
        // Calculate area boundaries
        float near_center = near_position_ * img_height;
        float focus_center = focus_position_ * img_height;
        float far_center = img_height - (far_position_ * img_height);
        
        // Calculate pure zone boundaries
        float near_pure_start = near_center - near_pure_size_ * 0.5f;
        float near_pure_end = near_center + near_pure_size_ * 0.5f;
        
        float focus_pure_start = focus_center - focus_pure_size_ * 0.5f;
        float focus_pure_end = focus_center + focus_pure_size_ * 0.5f;
        
        float far_pure_start = far_center - far_pure_size_ * 0.5f;
        float far_pure_end = far_center + far_pure_size_ * 0.5f;
        
        float result;
        
        // Check if pixel is in any pure zone first
        if (pixel_y >= near_pure_start && pixel_y <= near_pure_end) {
            result = near_focus_;
        }
        else if (pixel_y >= focus_pure_start && pixel_y <= focus_pure_end) {
            result = focus_plane_;
        }
        else if (pixel_y >= far_pure_start && pixel_y <= far_pure_end) {
            result = far_focus_;
        }
        else {
            // Not in pure zone - check for gradients between areas
            
            // Between near and focus areas
            if (pixel_y > near_pure_end && pixel_y < focus_pure_start) {
                float t = (pixel_y - near_pure_end) / (focus_pure_start - near_pure_end);
                result = near_focus_ + t * (focus_plane_ - near_focus_);
            }
            // Between focus and far areas
            else if (pixel_y > focus_pure_end && pixel_y < far_pure_start) {
                float t = (pixel_y - focus_pure_end) / (far_pure_start - focus_pure_end);
                result = focus_plane_ + t * (far_focus_ - focus_plane_);
            }
            // Below near area
            else if (pixel_y < near_pure_start) {
                result = near_focus_;
            }
            // Above far area
            else if (pixel_y > far_pure_end) {
                result = far_focus_;
            }
            // Between overlapping areas - blend based on distance
            else {
                // Find closest pure zone
                float dist_to_near = fabs(pixel_y - near_center);
                float dist_to_focus = fabs(pixel_y - focus_center);
                float dist_to_far = fabs(pixel_y - far_center);
                
                if (dist_to_near <= dist_to_focus && dist_to_near <= dist_to_far) {
                    result = near_focus_;
                }
                else if (dist_to_focus <= dist_to_far) {
                    result = focus_plane_;
                }
                else {
                    result = far_focus_;
                }
            }
        }
        
        return result;
    }

public:
    void knobs(Knob_Callback f) override
    {
        BeginGroup(f, "Focus Values");
        Float_knob(f, &near_focus_, "near_focus", "Near Focus");
        SetRange(f, 0.0, 10.0);
        Tooltip(f, "Near focus value (default 0.5)");
        
        Float_knob(f, &focus_plane_, "focus_plane", "Focus Plane");
        SetRange(f, 0.0, 10.0);
        Tooltip(f, "Focus plane value (default 1.0)");
        
        Float_knob(f, &far_focus_, "far_focus", "Far Focus");
        SetRange(f, 0.0, 10.0);
        Tooltip(f, "Far focus value (default 5.0)");
        EndGroup(f);
        
        BeginGroup(f, "Positions");
        Float_knob(f, &near_position_, "near_position", "Near Position");
        SetRange(f, 0.0, 1.0);
        Tooltip(f, "Near focus area position from bottom (0-1, 0=bottom)");
        
        Float_knob(f, &focus_position_, "focus_position", "Focus Position");
        SetRange(f, 0.0, 1.0);
        Tooltip(f, "Focus plane position (0-1, 0.5=center)");
        
        Float_knob(f, &far_position_, "far_position", "Far Position");
        SetRange(f, 0.0, 1.0);
        Tooltip(f, "Far focus area position from top (0-1, 0=top)");
        EndGroup(f);
        
        BeginGroup(f, "Pure Zone Sizes");
        Float_knob(f, &near_pure_size_, "near_pure_size", "Near Pure Size");
        SetRange(f, 0.0, 100.0);
        Tooltip(f, "Pure near focus area size in pixels");
        
        Float_knob(f, &focus_pure_size_, "focus_pure_size", "Focus Pure Size");
        SetRange(f, 0.0, 100.0);
        Tooltip(f, "Pure focus plane area size in pixels");
        
        Float_knob(f, &far_pure_size_, "far_pure_size", "Far Pure Size");
        SetRange(f, 0.0, 100.0);
        Tooltip(f, "Pure far focus area size in pixels");
        EndGroup(f);
        
        Float_knob(f, &rotation_, "rotation", "Rotation");
        SetRange(f, -180.0, 180.0);
        Tooltip(f, "Rotation angle in degrees");
        
        Bool_knob(f, &invert_, "invert", "Invert");
        Tooltip(f, "Invert the gradient");
    }

    const char* Class() const override { return "FocusGradient"; }
    const char* node_help() const override
    {
        return "Creates a gradient between 3 independent moveable focus areas with pure zones and intersection gradients.";
    }
    
    static const Iop::Description d;
};

const Iop::Description FocusGradient::d("FocusGradient", "Image/FocusGradient", FocusGradient::create);