package vista;

import controlador.ControladorCita;
import controlador.ControladorUsuario;
import com.toedter.calendar.JDateChooser;
import java.util.List;
import java.util.ArrayList;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.*;
import java.util.*;
import org.jfree.chart.*;
import org.jfree.chart.plot.*;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

public class EstadisticaVista extends JFrame {

    private JTextField txtDNI;
    private JTextField txtNombreObstetra;
    private JCheckBox[] chkProgramas;
    // FIX: Cambiado 'calendario' por 'calendarioDesde' y 'calendarioHasta'
    private JDateChooser calendarioDesde;
    private JDateChooser calendarioHasta;
    private JTable tabla;
    private DefaultTableModel modeloTabla;
    private ControladorCita controladorCita;
    private ControladorUsuario controladorUsuario;
    private JPanel panelGrafico;
    private String[] nombresProgramas = {"Papanicolaou", "IVA", "VPH", "Consejería", "Examen de mamas"};

    public EstadisticaVista() {
        setTitle("Estadísticas de Programas Preventivos");
        setSize(1000, 700);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setLocationRelativeTo(null);

        controladorCita = new ControladorCita();
        controladorUsuario = new ControladorUsuario(); // FIX: Asegurado que se inicializa

        JPanel panelFiltros = new JPanel(new GridLayout(4, 1));
        panelFiltros.setBorder(BorderFactory.createTitledBorder("Filtros"));

        // Filtro por DNI
        JPanel panelDNI = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelDNI.add(new JLabel("DNI Obstetra:"));
        txtDNI = new JTextField(10);
        txtNombreObstetra = new JTextField(20);
        txtNombreObstetra.setEditable(false);
        panelDNI.add(txtDNI);
        panelDNI.add(new JLabel("Nombre:"));
        panelDNI.add(txtNombreObstetra);
        panelFiltros.add(panelDNI);

        txtDNI.addKeyListener(new KeyAdapter() {
            public void keyReleased(KeyEvent e) {
                String dni = txtDNI.getText().trim();
                if (!dni.isEmpty()) {
                    // FIX: Uso de obtenerNombrePorDni que se espera esté en ControladorUsuario
                    String nombre = controladorUsuario.obtenerNombrePorDni(dni);
                    txtNombreObstetra.setText(nombre != null ? nombre : "No encontrado");
                } else {
                    txtNombreObstetra.setText("");
                }
                // FIX: Actualizar tabla y gráfico al cambiar el DNI
                actualizarTablaYGrafico("barras");
            }
        });

        // Filtro por programas
        JPanel panelProgramas = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelProgramas.add(new JLabel("Programas:"));
        chkProgramas = new JCheckBox[nombresProgramas.length];
        for (int i = 0; i < nombresProgramas.length; i++) {
            chkProgramas[i] = new JCheckBox(nombresProgramas[i], true);
            panelProgramas.add(chkProgramas[i]);
            // FIX: Añadir listener para actualizar al cambiar selección de programa
            chkProgramas[i].addActionListener(e -> actualizarTablaYGrafico("barras"));
        }
        panelFiltros.add(panelProgramas);

        // FIX: Filtro por rango de fechas (Desde - Hasta)
        JPanel panelFecha = new JPanel(new FlowLayout(FlowLayout.LEFT));
        panelFecha.add(new JLabel("Fecha Desde:"));
        calendarioDesde = new JDateChooser();
        calendarioDesde.setDate(new java.util.Date()); // Fecha actual por defecto
        panelFecha.add(calendarioDesde);

        panelFecha.add(new JLabel("Fecha Hasta:"));
        calendarioHasta = new JDateChooser();
        calendarioHasta.setDate(new java.util.Date()); // Fecha actual por defecto
        panelFecha.add(calendarioHasta);

        panelFiltros.add(panelFecha);

        // FIX: Añadir listeners para los cambios de fecha
        calendarioDesde.getDateEditor().addPropertyChangeListener(e -> {
            if ("date".equals(e.getPropertyName())) {
                actualizarTablaYGrafico("barras");
            }
        });
        calendarioHasta.getDateEditor().addPropertyChangeListener(e -> {
            if ("date".equals(e.getPropertyName())) {
                actualizarTablaYGrafico("barras");
            }
        });


        // Botones para graficar
        JPanel panelBotones = new JPanel();

        JButton btnBarras = new JButton("Gráfico de Barras");
        JButton btnCircular = new JButton("Gráfico Circular");
        JButton btnLineal = new JButton("Gráfico Lineal");
        JButton btnVolver = new JButton("Volver");

        btnVolver.setBackground(new Color(220, 53, 69));
        btnVolver.setForeground(Color.WHITE);
        btnVolver.setFocusPainted(false);
        btnVolver.setFont(new Font("Arial", Font.BOLD, 14));

        panelBotones.add(btnBarras);
        panelBotones.add(btnCircular);
        panelBotones.add(btnLineal);
        panelBotones.add(btnVolver);

        panelFiltros.add(panelBotones);

        // Acción del botón volver
        btnVolver.addActionListener(e -> {
            new MenuAdminVista().setVisible(true);
            dispose();
        });

        // Tabla
        modeloTabla = new DefaultTableModel(new Object[]{"Programa", "Total", "Atendidas", "Porcentaje"}, 0);
        tabla = new JTable(modeloTabla);
        JScrollPane scroll = new JScrollPane(tabla);

        // Panel gráfico
        panelGrafico = new JPanel();
        panelGrafico.setPreferredSize(new Dimension(500, 300));
        panelGrafico.setLayout(new BorderLayout());

        // Eventos para botones
        btnBarras.addActionListener(e -> graficar("barras"));
        btnCircular.addActionListener(e -> graficar("circular"));
        btnLineal.addActionListener(e -> graficar("lineal"));

        // Layout principal
        JPanel contenedor = new JPanel(new BorderLayout());
        contenedor.add(panelFiltros, BorderLayout.NORTH);
        contenedor.add(scroll, BorderLayout.CENTER);
        contenedor.add(panelGrafico, BorderLayout.SOUTH);

        add(contenedor);
        actualizarTablaYGrafico("barras"); // por defecto
    }

    private void actualizarTablaYGrafico(String tipoGrafico) {
        modeloTabla.setRowCount(0);
        String dni = txtDNI.getText().trim();
        // FIX: Obtener fechas de los dos calendarios
        Date fechaDesde = calendarioDesde.getDate();
        Date fechaHasta = calendarioHasta.getDate();

        List<String> programasSeleccionados = new ArrayList<>();
        for (JCheckBox chk : chkProgramas) {
            if (chk.isSelected()) {
                programasSeleccionados.add(chk.getText());
            }
        }

        // FIX: Llamar al método con los dos parámetros de fecha
        List<Map<String, Object>> datos = controladorCita.obtenerEstadisticasPorProgramaFiltrado(
                dni.isEmpty() ? null : dni,
                programasSeleccionados,
                fechaDesde, // FIX: Pasar fechaDesde
                fechaHasta  // FIX: Pasar fechaHasta
        );

        for (Map<String, Object> fila : datos) {
            modeloTabla.addRow(new Object[]{
                fila.get("programa"),
                fila.get("total"),
                fila.get("atendidas"),
                String.format("%.2f%%", fila.get("porcentaje"))
            });
        }

        graficar(tipoGrafico);
    }

    private void graficar(String tipo) {
        panelGrafico.removeAll();

        if (modeloTabla.getRowCount() == 0) {
            panelGrafico.add(new JLabel("Sin datos para graficar"), BorderLayout.CENTER);
            panelGrafico.revalidate();
            panelGrafico.repaint();
            return;
        }

        switch (tipo) {
            case "barras" -> {
                DefaultCategoryDataset dataset = new DefaultCategoryDataset();
                for (int i = 0; i < modeloTabla.getRowCount(); i++) {
                    String programa = modeloTabla.getValueAt(i, 0).toString();
                    // FIX: Asegurar que la conversión a int sea robusta
                    int atendidas = Integer.parseInt(modeloTabla.getValueAt(i, 2).toString());
                    dataset.addValue(atendidas, "Atendidas", programa);
                }
                JFreeChart chart = ChartFactory.createBarChart("Atenciones por Programa", "Programa", "Cantidad", dataset, PlotOrientation.VERTICAL, false, true, false);
                panelGrafico.add(new ChartPanel(chart), BorderLayout.CENTER);
            }
            case "circular" -> {
                DefaultPieDataset dataset = new DefaultPieDataset();
                for (int i = 0; i < modeloTabla.getRowCount(); i++) {
                    String programa = modeloTabla.getValueAt(i, 0).toString();
                    // FIX: Asegurar que la conversión a int sea robusta
                    int atendidas = Integer.parseInt(modeloTabla.getValueAt(i, 2).toString());
                    dataset.setValue(programa, atendidas);
                }
                JFreeChart chart = ChartFactory.createPieChart("Distribución por Programa", dataset, true, true, false);
                panelGrafico.add(new ChartPanel(chart), BorderLayout.CENTER);
            }
            case "lineal" -> {
                DefaultCategoryDataset dataset = new DefaultCategoryDataset();
                for (int i = 0; i < modeloTabla.getRowCount(); i++) {
                    String programa = modeloTabla.getValueAt(i, 0).toString();
                    // FIX: Asegurar que la conversión a int sea robusta
                    int atendidas = Integer.parseInt(modeloTabla.getValueAt(i, 2).toString());
                    dataset.addValue(atendidas, "Atendidas", programa);
                }
                JFreeChart chart = ChartFactory.createLineChart("Tendencia de Atención", "Programa", "Cantidad", dataset, PlotOrientation.VERTICAL, false, true, false);
                panelGrafico.add(new ChartPanel(chart), BorderLayout.CENTER);
            }
        }

        panelGrafico.revalidate();
        panelGrafico.repaint();
    }
}
