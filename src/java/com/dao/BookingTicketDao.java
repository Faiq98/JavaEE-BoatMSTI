/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.dao;

import com.bean.BoatBean;
import com.bean.BoatServiceBean;
import com.bean.BookingTicketBean;
import com.bean.CustomerBean;
import com.bean.PaymentBean;
import com.bean.TourismCompanyBean;
import com.util.DBConnection;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author fhfai
 */
@MultipartConfig(maxFileSize = 16177216)
public class BookingTicketDao {

    private Connection con;
    private int result;

//    public BookingTicketDao() {
//        con = DBConnection.createConnection();
//    }

    public List<BoatServiceBean> checkAvailability(String fromLocation, String toLocation, String departDate) {
        List<BoatServiceBean> BoatServiceAll = new ArrayList<BoatServiceBean>();
        BoatServiceBean bsb;
        try {
            con = DBConnection.createConnection();
            System.out.println("serviceDao: " + fromLocation + " to " + toLocation + " DepartDate " + departDate);
//            String query = "select tourismcompany.companyName, boatservice_info.serviceID, boatservice_info.fromLocation, boatservice_info.toLocation, boatservice_info.departureTime, boat_info.boatType, boat_info.boatCapacity, (boat_info.boatCapacity-sum(bookingticket_info.totalBook)) as availableSeat, bookingticket_info.departDate, boatservice_info.AdultPrice, boatservice_info.ChildPrice, boatservice_info.InfantPrice from bookingticket_info left join boatservice_info on bookingticket_info.serviceID = boatservice_info.serviceID inner join boat_info using (boatID) inner join tourismcompany on tourismcompany.companyID = boatservice_info.companyID where bookingticket_info.departDate =? and boatservice_info.fromLocation=? and boatservice_info.toLocation=? group by boatservice_info.serviceID";
            String query = "select tourismcompany.companyName, boatservice_info.serviceID, boatservice_info.serviceName, boatservice_info.fromLocation, boatservice_info.toLocation, boatservice_info.departureTime, boat_info.boatType, (boat_info.boatCapacity-sum(bookingticket_info.totalBook)) as availableSeat, bookingticket_info.departDate, boatservice_info.AdultPrice, boatservice_info.ChildPrice, boatservice_info.InfantPrice from bookingticket_info left join boatservice_info on bookingticket_info.serviceID = boatservice_info.serviceID inner join boat_info using (boatID) inner join tourismcompany on tourismcompany.companyID = boatservice_info.companyID where bookingticket_info.departDate =? and boatservice_info.fromLocation=? and boatservice_info.toLocation=? group by boatservice_info.serviceID union select tourismcompany.companyName, boatservice_info.serviceID, boatservice_info.serviceName, boatservice_info.fromLocation, boatservice_info.toLocation, boatservice_info.departureTime, boat_info.boatType, boat_info.boatCapacity, bookingticket_info.departDate, boatservice_info.AdultPrice, boatservice_info.ChildPrice, boatservice_info.InfantPrice from boatservice_info left join bookingticket_info on bookingticket_info.serviceID = boatservice_info.serviceID inner join boat_info using (boatID) inner join tourismcompany on tourismcompany.companyID = boatservice_info.companyID where (bookingticket_info.departDate <>? or bookingticket_info.departDate is null) and boatservice_info.fromLocation=? and boatservice_info.toLocation=? group by boatservice_info.serviceID order by serviceID asc, availableSeat asc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, departDate);
            ps.setString(2, fromLocation);
            ps.setString(3, toLocation);
            ps.setString(4, departDate);
            ps.setString(5, fromLocation);
            ps.setString(6, toLocation);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {

                bsb = new BoatServiceBean();

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyName(rs.getString("companyName"));

                bsb.setCompanyID(tcb);

                bsb.setServiceID(rs.getInt("serviceID"));
                bsb.setServiceName(rs.getString("serviceName"));
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));
                bsb.setDepartureTime(rs.getString("departureTime"));

                BoatBean bb = new BoatBean();
                bb.setBoatType(rs.getString("boatType"));
                bb.setBoatCapacity(rs.getInt("availableSeat"));

                bsb.setBoatID(bb);

//                bsb.setServiceName(rs.getString(7));
//                bsb.setServiceType(rs.getString(6));
                bsb.setAdultPrice(rs.getDouble("AdultPrice"));
                bsb.setChildPrice(rs.getDouble("ChildPrice"));
                bsb.setInfantPrice(rs.getDouble("InfantPrice"));

                BoatServiceAll.add(bsb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception is at retrieve all: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE BtdCheckAvailability: " + se);
            }
        }
        return BoatServiceAll;
    }

    public int addBookingTicket(BookingTicketBean btb) throws SQLException {
        int custID = btb.getCustID().getCustID();
        int serviceID = btb.getServiceID().getServiceID();
        String referenceNo = btb.getReferenceNo().getReferenceNo();
        String departDate = btb.getDepartDate();
//        String returnDate = btb.getReturnDate();
        int bookAdult = btb.getBookAdult();
        int bookChild = btb.getBookChild();
        int bookInfant = btb.getBookInfant();
        int totalBook = btb.getTotalBook();

        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            String query1 = "insert into bookingticket_info(custID, serviceID, referenceNo, departDate, bookAdult, bookChild, bookInfant, totalBook) values(?,?,?,?,?,?,?,?)";

            ps = con.prepareStatement(query1);
            ps.setInt(1, custID);
            ps.setInt(2, serviceID);
            ps.setString(3, referenceNo);
            ps.setString(4, departDate);
            ps.setInt(5, bookAdult);
            ps.setInt(6, bookChild);
            ps.setInt(7, bookInfant);
            ps.setInt(8, totalBook);

            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception addBookingTicket is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE BtdAddbookingTicket: " + se);
            }
        }
        return result;
    }

    public List<BookingTicketBean> allbookingTicketByCompID(int companyID) throws IOException {
        List<BookingTicketBean> allBtb = new ArrayList<BookingTicketBean>();
        BookingTicketBean btb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join customer using(custID) inner join boat_info using(boatID) where boatservice_info.companyID = ? and (bookingticket_info.status is null or bookingticket_info.status = 'Uncheck') order by bookingticket_info.bookID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                btb = new BookingTicketBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt(2));
                cb.setCustFirstName(rs.getString(26));
                cb.setCustPhone(rs.getString(29));
                cb.setCustEmail(rs.getString(30));

//                TourismCompanyBean tcb = new TourismCompanyBean();
//                tcb.setCompanyID(rs.getInt(2));
                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString(1));
                bb.setBoatType(rs.getString(34));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt(3));
//                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString(20));
                bsb.setToLocation(rs.getString(21));
                bsb.setDepartureTime(rs.getString(22));
                bsb.setServiceName(rs.getString(18));
                bsb.setBoatID(bb);

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(rs.getString(4));
                pb.setPaymentAmount(rs.getDouble(15));

                Blob blob = rs.getBlob(16);
                InputStream is = blob.getBinaryStream();
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                byte[] fileBytes = os.toByteArray();
                String base64File = Base64.getEncoder().encodeToString(fileBytes);

                is.close();
                os.close();

                pb.setPaymentReceipt(base64File);

                btb.setBookID(rs.getInt(5));
                btb.setCustID(cb);
                btb.setServiceID(bsb);
                btb.setReferenceNo(pb);
                btb.setBookDate(rs.getString(6));
                btb.setDepartDate(rs.getString(7));
                btb.setReturnDate(rs.getString(8));
                btb.setBookAdult(rs.getInt(9));
                btb.setBookChild(rs.getInt(10));
                btb.setBookInfant(rs.getInt(11));

                allBtb.add(btb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Exception booking ticket: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE allbookingticketBycompID: " + se);
            }
        }
        return allBtb;
    }

    public List<BookingTicketBean> allbookingTicketByIC(int custID) throws IOException {
        List<BookingTicketBean> allBtb = new ArrayList<BookingTicketBean>();
        BookingTicketBean btb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) inner join boat_info using(boatID) where custID = ? and (bookingticket_info.status is null or bookingticket_info.status = 'Uncheck') order by bookingticket_info.bookID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, custID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                btb = new BookingTicketBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt(6));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt(2));
                tcb.setCompanyName(rs.getString(26));

                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString(1));
                bb.setBoatType(rs.getString(37));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt(3));
                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString(20));
                bsb.setToLocation(rs.getString(21));
                bsb.setDepartureTime(rs.getString(22));
                bsb.setBoatID(bb);

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(rs.getString(4));
                pb.setPaymentAmount(rs.getDouble(16));

                Blob blob = rs.getBlob(17);
                InputStream is = blob.getBinaryStream();
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                byte[] fileBytes = os.toByteArray();
                String base64File = Base64.getEncoder().encodeToString(fileBytes);

                is.close();
                os.close();

                pb.setPaymentReceipt(base64File);

                btb.setBookID(rs.getInt(5));
                btb.setCustID(cb);
                btb.setServiceID(bsb);
                btb.setReferenceNo(pb);
                btb.setBookDate(rs.getString(7));
                btb.setDepartDate(rs.getString(8));
                btb.setReturnDate(rs.getString(9));
                btb.setBookAdult(rs.getInt(10));
                btb.setBookChild(rs.getInt(11));
                btb.setBookInfant(rs.getInt(12));

                allBtb.add(btb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Exception booking ticket: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE allbookingticketbyIC: " + se);
            }
        }
        return allBtb;
    }

    public List<BookingTicketBean> allbookingTicketByDate(String departDate) {
        List<BookingTicketBean> allBtb = new ArrayList<BookingTicketBean>();
        BookingTicketBean btb;
        try {
            con = DBConnection.createConnection();
            String query = "select * from bookingticket_info where departDate=?";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                btb = new BookingTicketBean();
                btb.setBookID(rs.getInt(1));

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt(2));

                btb.setCustID(cb);

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt(3));

                btb.setServiceID(bsb);

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(rs.getString(4));

                btb.setReferenceNo(pb);

                btb.setBookDate(rs.getString(5));
                btb.setDepartDate(rs.getString(6));
                btb.setReturnDate(rs.getString(7));
                btb.setBookAdult(rs.getInt(8));
                btb.setBookChild(rs.getInt(9));
                btb.setBookInfant(rs.getInt(10));

                allBtb.add(btb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Exception booking ticket: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE allbookingticketbydate: " + se);
            }
        }
        return allBtb;
    }

    public List<BookingTicketBean> allCheckBookingTicketByIC(int custID) throws IOException {
        List<BookingTicketBean> allBtb = new ArrayList<BookingTicketBean>();
        BookingTicketBean btb;
        try {
            con = DBConnection.createConnection();
            String Check = "Check";
            String query = "select * from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) inner join boat_info using(boatID) where custID = ? and bookingticket_info.status = ?  order by bookingticket_info.bookID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, custID);
            ps.setString(2, Check);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                btb = new BookingTicketBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt(6));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt(2));
                tcb.setCompanyName(rs.getString(26));

                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString(1));
                bb.setBoatType(rs.getString(37));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt(3));
                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString(20));
                bsb.setToLocation(rs.getString(21));
                bsb.setDepartureTime(rs.getString(22));
                bsb.setBoatID(bb);

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(rs.getString(4));
                pb.setPaymentAmount(rs.getDouble(16));

                Blob blob = rs.getBlob(17);
                InputStream is = blob.getBinaryStream();
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                byte[] fileBytes = os.toByteArray();
                String base64File = Base64.getEncoder().encodeToString(fileBytes);

                is.close();
                os.close();

                pb.setPaymentReceipt(base64File);

                btb.setBookID(rs.getInt(5));
                btb.setCustID(cb);
                btb.setServiceID(bsb);
                btb.setReferenceNo(pb);
                btb.setBookDate(rs.getString(7));
                btb.setDepartDate(rs.getString(8));
                btb.setReturnDate(rs.getString(9));
                btb.setBookAdult(rs.getInt(10));
                btb.setBookChild(rs.getInt(11));
                btb.setBookInfant(rs.getInt(12));

                allBtb.add(btb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Exception booking ticket ic: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE Btdallcheckbookingticket: " + se);
            }
        }
        return allBtb;
    }

    //UPDATE `bookingticket_info` SET `status` = 'Check' WHERE `bookingticket_info`.`bookID` = 30;
    public int updateStatus(BookingTicketBean btb) {
        String query = "update bookingticket_info set bookingticket_info.status = ? where bookingticket_info.bookID = ?";
        try {
            con = DBConnection.createConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, btb.getStatus());
            ps.setInt(2, btb.getBookID());
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("updatestatus : " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE Btdupdatestatus: " + se);
            }
        }
        return result;

    }

    public List<BookingTicketBean> allCheckbookingTicketByCompID(int companyID) throws IOException {
        List<BookingTicketBean> allCBtb = new ArrayList<BookingTicketBean>();
        BookingTicketBean cbtb;
        try {
            con = DBConnection.createConnection();
            String Check = "Check";
            String query = "select * from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join customer using(custID) inner join boat_info using(boatID) where boatservice_info.companyID = ? and bookingticket_info.status = ? order by bookingticket_info.bookID desc";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, companyID);
            ps.setString(2, Check);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cbtb = new BookingTicketBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt("custID"));
                cb.setCustFirstName(rs.getString("custFirstName"));
                cb.setCustPhone(rs.getString("custPhone"));
                cb.setCustEmail(rs.getString("custEmail"));

//                TourismCompanyBean tcb = new TourismCompanyBean();
//                tcb.setCompanyID(rs.getInt(2));
                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString("boatID"));
                bb.setBoatType(rs.getString("boatType"));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt("serviceID"));
//                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString("fromLocation"));
                bsb.setToLocation(rs.getString("toLocation"));
                bsb.setDepartureTime(rs.getString("departureTime"));
                bsb.setServiceName(rs.getString("serviceName"));
                bsb.setBoatID(bb);

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(rs.getString("referenceNo"));
                pb.setPaymentAmount(rs.getDouble("paymentAmount"));

                Blob blob = rs.getBlob(16);
                InputStream is = blob.getBinaryStream();
                ByteArrayOutputStream os = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead = -1;

                while ((bytesRead = is.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                byte[] fileBytes = os.toByteArray();
                String base64File = Base64.getEncoder().encodeToString(fileBytes);

                is.close();
                os.close();

                pb.setPaymentReceipt(base64File);

                cbtb.setBookID(rs.getInt("bookID"));
                cbtb.setCustID(cb);
                cbtb.setServiceID(bsb);
                cbtb.setReferenceNo(pb);
                cbtb.setBookDate(rs.getString("bookDate"));
                cbtb.setDepartDate(rs.getString("departDate"));
                cbtb.setReturnDate(rs.getString("returnDate"));
                cbtb.setBookAdult(rs.getInt("bookAdult"));
                cbtb.setBookChild(rs.getInt("bookChild"));
                cbtb.setBookInfant(rs.getInt("bookInfant"));

                allCBtb.add(cbtb);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Exception booking ticket: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE BtdallcheckbookingticketbycompID: " + se);
            }
        }
        return allCBtb;
    }

    public BookingTicketBean oneBookingTicket(int bookID) {
        BookingTicketBean btb = new BookingTicketBean();
        try {
            con = DBConnection.createConnection();
            String query = "select * from bookingticket_info inner join payment_info using(referenceNo) inner join boatservice_info using(serviceID) inner join tourismcompany using(companyID) inner join boat_info using(boatID) where bookID = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                btb = new BookingTicketBean();

                CustomerBean cb = new CustomerBean();
                cb.setCustID(rs.getInt(6));

                TourismCompanyBean tcb = new TourismCompanyBean();
                tcb.setCompanyID(rs.getInt(2));
                tcb.setCompanyName(rs.getString(26));
                tcb.setCompanyEmail(rs.getString(31));

                BoatBean bb = new BoatBean();
                bb.setBoatID(rs.getString(1));
                bb.setBoatType(rs.getString(37));

                BoatServiceBean bsb = new BoatServiceBean();
                bsb.setServiceID(rs.getInt(3));
                bsb.setCompanyID(tcb);
                bsb.setFromLocation(rs.getString(20));
                bsb.setToLocation(rs.getString(21));
                bsb.setDepartureTime(rs.getString(22));
                bsb.setBoatID(bb);

                PaymentBean pb = new PaymentBean();
                pb.setReferenceNo(rs.getString(4));
                pb.setPaymentAmount(rs.getDouble(16));

                btb.setBookID(rs.getInt(5));
                btb.setCustID(cb);
                btb.setServiceID(bsb);
                btb.setReferenceNo(pb);
                btb.setBookDate(rs.getString(7));
                btb.setDepartDate(rs.getString(8));
                btb.setReturnDate(rs.getString(9));
                btb.setBookAdult(rs.getInt(10));
                btb.setBookChild(rs.getInt(11));
                btb.setBookInfant(rs.getInt(12));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Exception booking ticket: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE BtdOnebookingticket: " + se);
            }
        }
        return btb;
    }

//    public int updateBoat(BoatBean bb) {
//        try {
//            String query = "update boat_info set boatType=?, boatCapacity=? where boatID=?";
//            PreparedStatement ps = con.prepareStatement(query);
//            ps.setString(1, bb.getBoatType());
//            ps.setInt(2, bb.getBoatCapacity());
//            ps.setString(3, bb.getBoatID());
//            result = ps.executeUpdate();
//        } catch (Exception ex) {
//            System.out.println("Exception is: " + ex);
//        }
//        return result;
//    }
    public int deleteBookingTicket(int bookID) {
        try {
            con = DBConnection.createConnection();
            String query = "delete from bookingticket_info where bookID=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookID);
            result = ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception ex) {
            System.out.println("Exception deleteBookingTicket is: " + ex);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException se) {
                System.out.println("SE Btddeletebookingticket: " + se);
            }
        }
        return result;
    }

}
