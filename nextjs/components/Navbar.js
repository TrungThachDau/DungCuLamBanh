// components/Navbar.js
import React from "react";
import styles from "./Navbar.module.css";
const Navbar = () => {
    return (
        <nav className={`navbar navbar-expand-sm navbar-toggleable-sm mb-2 ${styles.navbar}`}>
            <div className="container">
                <a style={{marginLeft: "50px"}} className="navbar-brand"
                   href="/"

                ><img src="/logo/Whisk &Flourisk.svg" width="70px"/>
                </a>
                <div className="navbar-collapse collapse d-sm-inline-flex justify-content-between">
                    <ul className="navbar-nav flex-grow-1">
                        <li className="nav-item dropdown">
                            <a className="nav-link dropdown-toggle text-dark" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                Sản phẩm
                            </a>
                            <ul className="dropdown-menu">
                                <li><a className="dropdown-item">Tất cả sản phẩm</a>
                                </li>
                                <li><a className="dropdown-item">Sản phẩm bán chạy</a></li>
                                <li><a className="dropdown-item" asp-action="MembershipPolicy" asp-controller="Home">Quyền
                                    lợi khách hàng</a></li>
                            </ul>

                        </li>
                        <li>
                            <a className="nav-link text-dark" href="#">
                                Giảm giá
                            </a>
                        </li>
                        <li>
                            <a className="nav-link text-dark">Tra
                                cứu đơn hàng</a>
                        </li>
                        <li className="nav-item dropdown">
                            <a className="nav-link dropdown-toggle text-dark" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                Về chúng tôi
                            </a>
                            <ul className="dropdown-menu">
                                <li><a className="dropdown-item">Giới thiệu</a>
                                </li>
                                <li><a className="dropdown-item">Thông báo
                                    bảo mật</a></li>
                                <li><a className="dropdown-item">Quyền
                                    lợi khách hàng</a></li>
                            </ul>

                        </li>
                        <li className="nav-item">

                            <ul>
                                <div className="search-container">
                                    <form method="get"
                                          className={styles.searchForm}>
                                        <input className={`col-sm-12 ${styles.transparentSearchBar}`} type="search" name="search"
                                               placeholder="Tìm sản phẩm..." required/>
                                        <input type="submit" value="Search" style={{display: "none"}}/>
                                    </form>
                                </div>

                            </ul>
                        </li>
                    </ul>
                </div>
                <form className="form-inline my-2 my-lg-0 d-flex justify-content-between">
                    <div>
                        <div className="dropstart" style={{position: "relative"}}>
                            <button aria-expanded="false" data-bs-toggle="dropdown"
                                    style={{width: "50px", borderRadius: "20px", color: "black"}}
                                    className="btn my-2 my-sm-0 ml-2" type="submit">
                                <span className=" material-symbols-outlined" style={{position: "relative",}}>
                                    shopping_bag
                                </span>

                            </button>
                            <div className="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                 aria-labelledby="alertsDropdown"
                                 style={{fontSize: "240"}}
                            >
                                <table className="table minicart">
                                    <tbody id="product-list">
                                    <tr>
                                        <td><a style={{fontSize: "9"}}>Giỏ hàng trống</a></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <a className="dropdown-item text-center btn btn-dark" style={{fontSize: "9"}}
                                >Xem giỏ hàng</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </nav>
    );
};
export default Navbar;
