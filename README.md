# Leaf Color Analysis Macro (ImageJ)

**Author:** Mario Ibarra Gómez  
**Last updated:** 2025  
**License:** MIT (recommended)  

## Overview  
This ImageJ macro computes the **mean red, green, and blue intensities** of a leaf within a binary mask. It is useful for leaf color analyses, comparisons among treatments, and further calculation of vegetation or greenness indices.

## Files  
- `leaf_color_mean.ijm` — Macro file (ImageJ Macro Language), **do not modify** core logic.  
- `README.md` — This documentation file.  
- (Optional) `examples/` — sample images and masks for testing.

## Requirements  
- Fiji / ImageJ (version 1.x)  
- RGB leaf images (standard image formats)  
- A binary mask image named exactly `Mascara` (same dimensions as leaf image)  
- Consistent capture settings (illumination, exposure, DPI/scale)

## Usage Instructions  
1. Open your leaf RGB image in ImageJ.  
   - The window title becomes `nombreImagen`.  
2. Open or generate the binary mask `Mascara`, where leaf pixels = white (non-zero), background = black (zero).  
3. Run the macro (`Plugins → Macros → Run…` or place in your macros folder).  
4. A dialog will show:

   ```
   Imagen: <nombreImagen>

   R: <PromedioRojo> | G: <PromedioVerde> | B: <PromedioAzul>

   Copiar valores: <string>
   ```

5. The line `R: x | G: y | B: z` is copy‑ready for pasting into Excel or your database.  
6. Choose to analyze another image or exit. The macro closes mask and channel windows as it proceeds.

## Technical Description  
- For each channel (red, green, blue), the macro performs `imageCalculator("AND", <channel>, "Mascara")` to mask the channel.  
- Then it uses `getRawStatistics(...)` to obtain histogram counts.  
- It discards zero (background) pixels and computes:

  \[
  	ext{Promedio}_	ext{channel} = rac{\sum_{i=1}^{255} i \cdot h_i}{\sum_{i=1}^{255} h_i}
  \]

  where \(h_i\) is the masked histogram count for intensity \(i\).  
- The result is displayed in a dialog and can be copied.

## Vegetation / Greenness Indices (optional)  
With the computed mean R, G, B values, you can derive indices for greenness or leaf color:

| Index | Formula (using means) | Comments |
|---|---|---|
| ExG | 2G - R - B | Common “excess green” index |
| GLI | (2G - R - B) / (2G + R + B) | Normalized green leaf index |
| VARI | (g - r) / (g + r - b) | Visible Atmospherically Resistant Index |

Where `r, g, b` are normalized channel means (e.g. r = R / (R+G+B)).

## Best Practices  
- Ensure the mask accurately covers all leaf area, no holes or background spillover.  
- Use uniform lighting and avoid shadows or reflections.  
- Keep imaging settings consistent across all samples.  
- Document the leaf name, DPI or scale, mask method, and macro settings.  
- For batch processing, wrap the macro in a script or macro loop to iterate through a folder of images.

## Handling Damaged Leaves  
If part of the leaf (e.g. tip) is missing, you can still estimate area by:

- Using your established **leaf area calibration equation** (based on length × width) to estimate the missing portion.  
- Reconstructing contours via symmetry, interpolation, or morphological fitting (if damage is small).  
- Documenting clearly that the area for damaged leaves is estimated via calibration and not direct measurement.

## Citation Suggestions  
When using or referring to this method, you may cite:

- ImageJ Macro Reference Guide. Retrieved from https://imagej.net/ij/docs/macro_reference_guide.pdf  
- Murakami, P. F., Turner, M. R., van den Berg, A. K., & Schaberg, P. G. (2005). *An instructional guide for leaf color analysis using digital imaging software*. U.S. Forest Service Northeastern Research Station.  
- Woebbecke, D. M., et al. (1995). Green‑related color indices for plant segmentation (ExG basis).


---

## Note on Methodological Inspiration
The structure of the usage instructions and the general workflow described in this README 
are inspired by the USDA Forest Service instructional guide for leaf color analysis:

Murakami, P. F., Turner, M. R., Van Den Berg, A. K., & Schaberg, P. G. (2005). 
*An instructional guide for leaf color analysis using digital imaging software*. 
U.S. Forest Service, Northeastern Research Station. 
https://doi.org/10.2737/ne-gtr-327

---
## License (MIT)  
```
MIT License

Copyright (c) 2025 Mario Ibarra Gómez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

... (standard MIT text continues) ...
```

## Repository Setup & Execution  
```bash
git clone [https://github.com/tu_usuario/tu_repo_leafcolor.git
cd tu_repo_leafcolor](https://github.com/MarioIbago/Leaf-Color-Metrics-from-RGB-Scans-ImageJ-Macro-/)
# Place leaf_color_mean.ijm here
open Fiji/ImageJ → Plugins → Macros → Install… → select leaf_color_mean.ijm
# Run with image + mask pair
```
