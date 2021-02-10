package com.dao;

import com.bean.ReportBean;
import com.bean.TourismCompanyBean;
import com.google.gson.Gson;
import com.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig(maxFileSize = 16177216)
public class ReportDao {

    private Connection con;
    private int result;

//    public ReportDao() {
//        con = DBConnection.createConnection();
//    }
//    public String addReport(ReportBean rb) throws SQLException {
//
//    }
    public String generateReport(int companyID) {
        Map<Object, Object> map = new HashMap<Object, Object>();
        List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();
        Gson gsonObj = new Gson();
        String dataPoints = "";
        String xLabel, yVal;

        try {
            con = DBConnection.createConnection();
            String query = "select boatservice_info.toLocation, sum(bookingticket_info.totalBook) as totalCustomer from boatservice_info inner join bookingticket_info using(serviceID) where companyID=? and month(bookingticket_info.bookDate) = month(CURRENT_DATE) and boatservice_info.toLocation like '%island%' group by toLocation";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            System.out.println(companyID);
            ResultSet rs = ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()) {
                xLabel = rs.getString("toLocation");
                yVal = rs.getString("totalCustomer");
                map = new HashMap<Object, Object>();
                map.put("label", xLabel);
                map.put("y", Double.parseDouble(yVal));
                list.add(map);
                dataPoints = gsonObj.toJson(list);
                System.out.println(dataPoints);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception generateReport: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rdgeneratereport: " + se);
            }
        }
        return dataPoints;
    }

    public int addReport(ReportBean rb) throws SQLException {
        int companyID = rb.getCompanyID().getCompanyID();
        int totalCustomer = rb.getTotalCustomer();
        double sales = rb.getSales();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query = "insert into report_info(companyID, reportDate, totalCustomer, sales) values(?,concat(monthname(current_date), year(current_date)),?,?)";
            ps = con.prepareStatement(query);
            ps.setObject(1, companyID);
            ps.setInt(2, totalCustomer);
            ps.setDouble(3, sales);

            result = ps.executeUpdate();

            ps.close();
            con.close();

        } catch (Exception ex) {
            System.out.println("Exception is rd addreport: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rd addreport: " + se);
            }
        }
        return result;
    }

    public List<ReportBean> displayReport(int companyID) {
        List<ReportBean> allReport = new ArrayList<ReportBean>();
        ReportBean rb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from report_info where companyID=? order by report_info.reportID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rb = new ReportBean();

                rb.setReportID(rs.getInt("reportID"));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(companyID);
                rb.setCompanyID(tcb);

                rb.setReportDate(rs.getString("reportDate"));
                rb.setTotalCustomer(rs.getInt("totalCustomer"));
                rb.setSales(rs.getDouble("sales"));
                allReport.add(rb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is retreiveALlBoatByID: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE retrieveAllBoatByID: " + se);
            }
        }
        return allReport;
    }
    
    public ReportBean reportById(int reportID) {
        ReportBean rb = new ReportBean();
        try {
            con = DBConnection.createConnection();
            String query = "select * from report_info where reportID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, reportID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rb.setReportID(rs.getInt("reportID"));
                rb.setReportDate(rs.getString("reportDate"));
                rb.setTotalCustomer(rs.getInt("totalCustomer"));
                rb.setSales(rs.getDouble("sales"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception reportByID is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE reportByID: " + se);
            }
        }
        return rb;
    }

    public String getTotalCustomer(int companyID) {
        String totalCustomer = null;
        try {
            con = DBConnection.createConnection();
            String query = "select sum(bookingticket_info.totalBook) as totalcustomer from bookingticket_info inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) where tourismcompany.companyID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                totalCustomer = rs.getString("totalCustomer");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is rd totalcustomer: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rd totalcustomer: " + se);
            }
        }
        return totalCustomer;
    }

    public String getMonthlyCustomer(int companyID) {
        String totalCustomer = null;
        try {
            con = DBConnection.createConnection();
            String query = "select sum(bookingticket_info.totalBook) as totalcustomer from bookingticket_info inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) where tourismcompany.companyID = ? and month(bookingticket_info.bookDate) = month(current_date)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                totalCustomer = rs.getString("totalCustomer");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is rd monthlycustomer: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rd monthlycustomer: " + se);
            }
        }
        return totalCustomer;
    }

    public String getTotalSales(int companyID) {
        String totalSales = null;
        try {
            con = DBConnection.createConnection();
            String query = "select sum(payment_info.paymentAmount) as totalsales from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) where tourismcompany.companyID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                totalSales = rs.getString("totalsales");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is rd totalsales: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rd totalsales: " + se);
            }
        }
        return totalSales;
    }

    public String getMonthlySales(int companyID) {
        String totalSales = null;
        try {
            con = DBConnection.createConnection();
            String query = "select sum(payment_info.paymentAmount) as totalsales from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) where tourismcompany.companyID = ? and month(payment_info.paymentDate) = month(current_date)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                totalSales = rs.getString("totalsales");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is rd totalsales: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rd totalsales: " + se);
            }
        }
        return totalSales;
    }

    public String salesTrend(int companyID) {
        Map<Object, Object> map = new HashMap<Object, Object>();
        List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();
        Gson gsonObj = new Gson();
        String salesTrend = "";
        String xLabel, yVal;

        try {
            con = DBConnection.createConnection();
            String query = "select * from report_info where companyID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            System.out.println(companyID);
            ResultSet rs = ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
            while (rs.next()) {
                xLabel = rs.getString("reportDate");
                yVal = rs.getString("sales");
                map = new HashMap<Object, Object>();
                map.put("label", xLabel);
                map.put("y", Double.parseDouble(yVal));
                list.add(map);
                salesTrend = gsonObj.toJson(list);
                System.out.println("sales: " + salesTrend);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception generateReport: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE rdgeneratereport: " + se);
            }
        }
        return salesTrend;
    }

//    public TourismCompanyBean oneTourismCompany(String companyEmail) {
//        TourismCompanyBean tcb = new TourismCompanyBean();
//
//        try {
//            String query = "SELECT tourismcompany.companyID, tourismcompany.companyName, tourismcompany.companyAbout, tourismcompany.companyImg, tourismcompany.companyLicense, tourismcompany.companyPhone, tourismcompany.companyEmail, tourismcompany.companyAddress1, tourismcompany.companyAddress2, address_info.addPoscode, address_info.addCity, address_info.addState, tourismcompany.companyPassword FROM tourismcompany INNER JOIN address_info ON tourismcompany.addPoscode = address_info.addPoscode WHERE tourismcompany.companyEmail = ?";
//            PreparedStatement ps = con.prepareStatement(query);
//            ps.setString(1, companyEmail);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                tcb.setCompanyID(rs.getInt(1));
//                tcb.setCompanyName(rs.getString(2));
//                tcb.setCompanyAbout(rs.getString(3));
//                Blob blob = rs.getBlob(4);
//
//                InputStream inputStream = blob.getBinaryStream();
//                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//                byte[] buffer = new byte[4096];
//                int bytesRead = -1;
//
//                while ((bytesRead = inputStream.read(buffer)) != -1) {
//                    outputStream.write(buffer, 0, bytesRead);
//                }
//
//                byte[] imageBytes = outputStream.toByteArray();
//                String base64Image = Base64.getEncoder().encodeToString(imageBytes);
//
//                inputStream.close();
//                outputStream.close();
//
//                tcb.setCompanyImg(base64Image);
//                tcb.setCompanyLicense(rs.getString(5));
//                tcb.setCompanyPhone(rs.getString(6));
//                tcb.setCompanyEmail(rs.getString(7));
//                tcb.setCompanyAddress1(rs.getString(8));
//                tcb.setCompanyAddress2(rs.getString(9));
//
//                AddressBean ab = new AddressBean();
//                ab.setAddPoscode(rs.getInt(10));
//                ab.setAddCity(rs.getString(11));
//                ab.setAddState(rs.getString(12));
//                tcb.setAddPoscode(ab);
//
//                tcb.setCompanyPassword(rs.getString(13));
////
////                tcb = new TourismCompanyBean(rs.getInt(1), rs.getString(2), rs.getBytes(3),
////                        rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8),
////                        ab, rs.getString(12));
//            }
//        } catch (Exception ex) {
//            System.out.println("Exception is: " + ex);
//        }
//        return tcb;
//    }
//
//    public int updateTourismCompany(TourismCompanyBean tcb) {
//        try {
//            String query = "UPDATE `tourismcompany` SET `companyName` = ?, `companyAbout` = ?, `companyLicense` = ?, `companyPhone` = ?, `companyEmail` = ?, `companyAddress1` = ?, `companyAddress2` = ?, `addPoscode` = ?, `companyPassword` = ? WHERE `tourismcompany`.`companyID` = ?";
//            PreparedStatement pst = con.prepareStatement(query);
//            pst.setString(1, tcb.getCompanyName());
//            pst.setString(2, tcb.getCompanyAbout());
//            pst.setString(3, tcb.getCompanyLicense());
//            pst.setString(4, tcb.getCompanyPhone());
//            pst.setString(5, tcb.getCompanyEmail());
//            pst.setString(6, tcb.getCompanyAddress1());
//            pst.setString(7, tcb.getCompanyAddress2());
//            pst.setObject(8, tcb.getAddPoscode().getAddPoscode());
//            pst.setString(9, tcb.getCompanyPassword());
//            pst.setInt(10, tcb.getCompanyID());
//            result = pst.executeUpdate();
//
//        } catch (Exception ex) {
//            System.out.println("Exception update is: " + ex);
//        }
//        return result;
//    }
//
//    public int deleteTourismCompany(int companyID) {
//        try {
//            String query = "delete from tourismcompany where companyID=?";
//            PreparedStatement pst = con.prepareStatement(query);
//            pst.setInt(1, companyID);
//            result = pst.executeUpdate();
//        } catch (Exception ex) {
//            System.out.println("Exception is: " + ex);
//        }
//        return result;
//    }
    
    public int updateReport(ReportBean rb) {
        try {
            con = DBConnection.createConnection();
            String query = "update report_info set reportDate=?, totalCustomer=?, sales=? where reportID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, rb.getReportDate());
            ps.setInt(2, rb.getTotalCustomer());
            ps.setDouble(3, rb.getSales());
            ps.setInt(4, rb.getReportID());
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception update report is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE updateReport: " + se);
            }
        }
        return result;
    }
    
    public int deleteReport(int reportID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from report_info where reportID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, reportID);
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception delete report is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE deleteReport: " + se);
            }
        }
        return result;
    }

}
