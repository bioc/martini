// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#ifndef RCPP_martini_RCPPEXPORTS_H_GEN_
#define RCPP_martini_RCPPEXPORTS_H_GEN_

#include <RcppEigen.h>
#include <Rcpp.h>

namespace martini {

    using namespace Rcpp;

    namespace {
        void validateSignature(const char* sig) {
            Rcpp::Function require = Rcpp::Environment::base_env()["require"];
            require("martini", Rcpp::Named("quietly") = true);
            typedef int(*Ptr_validate)(const char*);
            static Ptr_validate p_validate = (Ptr_validate)
                R_GetCCallable("martini", "_martini_RcppExport_validate");
            if (!p_validate(sig)) {
                throw Rcpp::function_not_exported(
                    "C++ function with signature '" + std::string(sig) + "' not found in martini");
            }
        }
    }

    inline Eigen::VectorXd mincut_c(Eigen::VectorXd c, double eta, double lambda, Eigen::SparseMatrix<double,Eigen::ColMajor> W) {
        typedef SEXP(*Ptr_mincut_c)(SEXP,SEXP,SEXP,SEXP);
        static Ptr_mincut_c p_mincut_c = NULL;
        if (p_mincut_c == NULL) {
            validateSignature("Eigen::VectorXd(*mincut_c)(Eigen::VectorXd,double,double,Eigen::SparseMatrix<double,Eigen::ColMajor>)");
            p_mincut_c = (Ptr_mincut_c)R_GetCCallable("martini", "_martini_mincut_c");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_mincut_c(Shield<SEXP>(Rcpp::wrap(c)), Shield<SEXP>(Rcpp::wrap(eta)), Shield<SEXP>(Rcpp::wrap(lambda)), Shield<SEXP>(Rcpp::wrap(W)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (Rcpp::internal::isLongjumpSentinel(rcpp_result_gen))
            throw Rcpp::LongjumpException(rcpp_result_gen);
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<Eigen::VectorXd >(rcpp_result_gen);
    }

}

#endif // RCPP_martini_RCPPEXPORTS_H_GEN_
