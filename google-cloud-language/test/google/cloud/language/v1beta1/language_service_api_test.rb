# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "minitest/autorun"
require "google/cloud/language/v1beta1/language_service_api"
include Google::Cloud::Language::V1beta1

describe LanguageServiceApi do

  def stub_grpc_client
    mock_client = Minitest::Mock.new

    # Implement "method" method for the mock.
    def mock_client.method(name_symbol)
      # We return a lambda (an instance of Proc) instead of a Method, because
      # the latter can't be easily constructed on the fly. In practice, most
      # operations performed on Methods work on Procs. The differences are:
      # Proc implements: :yield, :lambda?, :binding
      # Method implements: :receiver, :name, :original_name, :owner, :unbind,
      #                    and :super_method
      lambda { |*args| public_send(name_symbol, *args) }
    end

    LanguageService::Stub.stub(:new, mock_client) { yield(mock_client) }
  end

  describe "#analyze_sentiment" do
    it "forwards calls to LanguageService::Stub" do
      stub_grpc_client do |mock_client|
        Document = Google::Cloud::Language::V1beta1::Document
        LanguageServiceApi = Google::Cloud::Language::V1beta1::LanguageServiceApi

        expected_request = AnalyzeSentimentRequest.new(
          document: Document.new,
        )

        mocked_response = AnalyzeSentimentResponse.new

        mock_client.expect(
          :analyze_sentiment,
          mocked_response,
          [expected_request, Hash],
        )

        language_service_api = LanguageServiceApi.new
        document = Document.new
        response = language_service_api.analyze_sentiment(document)

        # Verification:
        response.must_equal mocked_response


      end
    end
  end

  describe "#analyze_entities" do
    it "forwards calls to LanguageService::Stub" do
      stub_grpc_client do |mock_client|

        Document = Google::Cloud::Language::V1beta1::Document
        EncodingType = Google::Cloud::Language::V1beta1::EncodingType
        LanguageServiceApi = Google::Cloud::Language::V1beta1::LanguageServiceApi

        expected_request = AnalyzeEntitiesRequest.new(
          document: Document.new,
          encoding_type: EncodingType::NONE,
        )

        mocked_response = AnalyzeEntitiesResponse.new

        mock_client.expect(
          :analyze_entities,
          mocked_response,
          [expected_request, Hash],
        )

        language_service_api = LanguageServiceApi.new
        document = Document.new
        encoding_type = EncodingType::NONE
        response = language_service_api.analyze_entities(document, encoding_type)

        # Verification:
        response.must_equal mocked_response

      end
    end
  end

  describe "#annotate_text" do
    it "forwards calls to LanguageService::Stub" do
      stub_grpc_client do |mock_client|


        Document = Google::Cloud::Language::V1beta1::Document
        EncodingType = Google::Cloud::Language::V1beta1::EncodingType
        Features = Google::Cloud::Language::V1beta1::AnnotateTextRequest::Features
        LanguageServiceApi = Google::Cloud::Language::V1beta1::LanguageServiceApi

        expected_request = AnnotateTextRequest.new(
          document: Document.new,
          features: Features.new,
          encoding_type: EncodingType::NONE,
        )

        mocked_response = AnnotateTextResponse.new

        mock_client.expect(
          :annotate_text,
          mocked_response,
          [expected_request, Hash],
        )

        language_service_api = LanguageServiceApi.new
        document = Document.new
        features = Features.new
        encoding_type = EncodingType::NONE
        response = language_service_api.annotate_text(document, features, encoding_type)

        # Verification:
        response.must_equal mocked_response
      end
    end
  end

end
