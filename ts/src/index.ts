import {grpc} from "@improbable-eng/grpc-web";
import * as BankQuery from "../_proto/cosmos/bank/v1beta1/query_pb_service";
import * as StakingQuery from "../_proto/cosmos/staking/v1beta1/query_pb_service";
import { QueryParamsRequest} from "../_proto/cosmos/bank/v1beta1/query_pb";
import { QueryValidatorsRequest} from "../_proto/cosmos/staking/v1beta1/query_pb";
import { PageRequest } from "../_proto/cosmos/base/query/v1beta1/pagination_pb";

const API = "http://localhost:9091";


function getValidators() {
  var req = new QueryValidatorsRequest()
  var pageReq = new PageRequest();
  pageReq.setOffset(0);
  pageReq.setLimit(10);
  req.setPagination(pageReq);
  grpc.unary(StakingQuery.Query.Validators, {
    request: req,
    host: API,
    onEnd: res => {
      const { status, message } = res;
      if (status === grpc.Code.OK && message) {
        console.log(message.toObject())
      }
    }
  });
}

function getBankParams() {
  grpc.unary(BankQuery.Query.Params, {
    request: new QueryParamsRequest  (),
    host: API,
    onEnd: res => {
      const { status, message } = res;
      if (status === grpc.Code.OK && message) {
        console.log(message.toObject())
      }
    }
  });
}


getBankParams();
getValidators();
