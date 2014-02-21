function [] = pdfSave( name, width, height )

    set(gca,'FontSize',10,'FontName','Times');
    set(gcf, 'PaperPosition', [0 0 width height]);
    set(gcf, 'PaperSize', [width height]);
    saveas(gcf, name, 'pdf')

end

