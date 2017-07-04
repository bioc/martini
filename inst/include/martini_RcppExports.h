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
                R_GetCCallable("martini", "martini_RcppExport_validate");
            if (!p_validate(sig)) {
                throw Rcpp::function_not_exported(
                    "C++ function with signature '" + std::string(sig) + "' not found in martini");
            }
        }
    }

    inline List getRegressionStats(Eigen::MatrixXd X, Eigen::VectorXd Y) {
        typedef SEXP(*Ptr_getRegressionStats)(SEXP,SEXP);
        static Ptr_getRegressionStats p_getRegressionStats = NULL;
        if (p_getRegressionStats == NULL) {
            validateSignature("List(*getRegressionStats)(Eigen::MatrixXd,Eigen::VectorXd)");
            p_getRegressionStats = (Ptr_getRegressionStats)R_GetCCallable("martini", "martini_getRegressionStats");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_getRegressionStats(Rcpp::wrap(X), Rcpp::wrap(Y));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<List >(rcpp_result_gen);
    }

    inline Eigen::VectorXd maxflow(Eigen::SparseMatrix<double,Eigen::ColMajor> lW, Eigen::VectorXd c) {
        typedef SEXP(*Ptr_maxflow)(SEXP,SEXP);
        static Ptr_maxflow p_maxflow = NULL;
        if (p_maxflow == NULL) {
            validateSignature("Eigen::VectorXd(*maxflow)(Eigen::SparseMatrix<double,Eigen::ColMajor>,Eigen::VectorXd)");
            p_maxflow = (Ptr_maxflow)R_GetCCallable("martini", "martini_maxflow");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_maxflow(Rcpp::wrap(lW), Rcpp::wrap(c));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<Eigen::VectorXd >(rcpp_result_gen);
    }

    inline List readGWAS(std::string pedBasename, std::string phenoFile, std::string netPath, unsigned int encoding, double maf) {
        typedef SEXP(*Ptr_readGWAS)(SEXP,SEXP,SEXP,SEXP,SEXP);
        static Ptr_readGWAS p_readGWAS = NULL;
        if (p_readGWAS == NULL) {
            validateSignature("List(*readGWAS)(std::string,std::string,std::string,unsigned int,double)");
            p_readGWAS = (Ptr_readGWAS)R_GetCCallable("martini", "martini_readGWAS");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_readGWAS(Rcpp::wrap(pedBasename), Rcpp::wrap(phenoFile), Rcpp::wrap(netPath), Rcpp::wrap(encoding), Rcpp::wrap(maf));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<List >(rcpp_result_gen);
    }

    inline List runGin(Eigen::MatrixXd X, Eigen::VectorXd Y, Eigen::SparseMatrix<double,Eigen::ColMajor> network, Rcpp::List userSettings) {
        typedef SEXP(*Ptr_runGin)(SEXP,SEXP,SEXP,SEXP);
        static Ptr_runGin p_runGin = NULL;
        if (p_runGin == NULL) {
            validateSignature("List(*runGin)(Eigen::MatrixXd,Eigen::VectorXd,Eigen::SparseMatrix<double,Eigen::ColMajor>,Rcpp::List)");
            p_runGin = (Ptr_runGin)R_GetCCallable("martini", "martini_runGin");
        }
        RObject rcpp_result_gen;
        {
            RNGScope RCPP_rngScope_gen;
            rcpp_result_gen = p_runGin(Rcpp::wrap(X), Rcpp::wrap(Y), Rcpp::wrap(network), Rcpp::wrap(userSettings));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<List >(rcpp_result_gen);
    }

}

#endif // RCPP_martini_RCPPEXPORTS_H_GEN_