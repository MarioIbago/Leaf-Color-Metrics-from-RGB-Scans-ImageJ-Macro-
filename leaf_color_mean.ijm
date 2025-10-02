imageCalculator("AND", nombreImagen + " (red)", "Mascara");
getRawStatistics(nPixels, mean, min, max, std, histogram);
nonZeroPixels = nPixels - histogram[0];
if (nonZeroPixels > 0) {
    redSum = 0;
    for (i = 1; i < histogram.length; i++) {
        redSum += i * histogram[i];
    }
    PromedioRojo = redSum / nonZeroPixels;
} else {
    PromedioRojo = 0;
}

selectWindow(nombreImagen + " (green)");
imageCalculator("AND", nombreImagen + " (green)", "Mascara");
getRawStatistics(nPixels, mean, min, max, std, histogram);
nonZeroPixels = nPixels - histogram[0];
if (nonZeroPixels > 0) {
    greenSum = 0;
    for (i = 1; i < histogram.length; i++) {
        greenSum += i * histogram[i];
    }
    PromedioVerde = greenSum / nonZeroPixels;
} else {
    PromedioVerde = 0;
}

selectWindow(nombreImagen + " (blue)");
imageCalculator("AND", nombreImagen + " (blue)", "Mascara");
getRawStatistics(nPixels, mean, min, max, std, histogram);
nonZeroPixels = nPixels - histogram[0];
if (nonZeroPixels > 0) {
    blueSum = 0;
    for (i = 1; i < histogram.length; i++) {
        blueSum += i * histogram[i];
    }
    PromedioAzul = blueSum / nonZeroPixels;
} else {
    PromedioAzul = 0;
}
// Mostrar resultados en una ventana desplegable.

resultadosTexto = "R: " + d2s(PromedioRojo, 1) + " | G: " + d2s(PromedioVerde, 1) + " | B: " + d2s(PromedioAzul, 1);

Dialog.create("RESULTADOS");
Dialog.addMessage("Imagen: " + nombreImagen);
Dialog.addMessage("");
Dialog.addMessage("R: " + d2s(PromedioRojo, 1) + " | G: " + d2s(PromedioVerde, 1) + " | B: " + d2s(PromedioAzul, 1));
Dialog.addMessage("");
Dialog.addString("Copiar valores:", resultadosTexto, 50);
Dialog.addMessage("");
Dialog.addChoice("¿Analizar otra imagen?", newArray("Sí", "No"));
Dialog.show();

continuar = Dialog.getChoice();

close("Mascara");
if (isOpen(nombreImagen + " (red)")) close(nombreImagen + " (Rojo)");
if (isOpen(nombreImagen + " (green)")) close(nombreImagen + " (Verde)");
if (isOpen(nombreImagen + " (blue)")) close(nombreImagen + " (Azul)");

while (nImages > 1) {
    list = getList("image.titles");
    for (i = 0; i < list.length; i++) {
        if (list[i] != nombreImagen) {
            if (isOpen(list[i])) close(list[i]);
        }
    }
}

print("\\Clear");

if (continuar == "Sí") {
    runMacro(getInfo("macro.filepath"));
}
