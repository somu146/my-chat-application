import consumer from "./consumer";
import dayjs from "dayjs";
import relativeTime from "dayjs/plugin/relativeTime";
dayjs.extend(relativeTime);

$(document).on("turbolinks:load", function() {
  var $element = $('[data-channel-subscribe="group"]');
  var group_id = $element.data("group-id");

  consumer.subscriptions.create(
    {
      channel: "GroupChannel",
      group: group_id
    },

    {
      connected() {
        console.log("connected");
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log(data);
        var content = `<div class="flex items-center m-2">
            <div class="p-3 rounded-full bg-teal-200 msg-${data.user_id}">
              <img src="${
                data.user_avatar_url
              }" class="h-8 w-8 rounded-full object-cover object-fit" alt="Profile" />
            </div>     
            <div class="ml-1 w-full p-2 rounded-lg bg-teal-200 text-gray-900 msg-${data.user_id}">
              <div class="text-sm text-right">
                <small class="leading-tight text-gray-600 uppercase" data-role="message-date">${
                  data.username
                }</small>
              </div>
            <div data-role="message-text" class="text-base">${
              data.body
            }</div>
              <div class="text-sm text-right">
                <small class="leading-tight text-gray-600" data-role="message-date">${dayjs(
                  data.updated_at
                ).fromNow()}</small>
              </div>
            </div>
          </div>`;
        $element.append(content);
      }
    }
  );
});
