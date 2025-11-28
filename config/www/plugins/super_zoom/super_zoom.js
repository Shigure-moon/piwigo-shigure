document.addEventListener('DOMContentLoaded', function () {

  // Modal

  const openButton = document.querySelector("#superzoom-btn-open");
  const closeButton = document.querySelector("#superzoom-btn-close");
  const dialog = document.querySelector(".superzoom-dialog");

  if (openButton && dialog) {
    openButton.addEventListener("click", () => {
        dialog.showModal();
    });
  }

  if (closeButton && dialog) {
    closeButton.addEventListener("click", () => {
        dialog.close();
    });
  }

  // WheelZoom
  var superzoomContent = document.getElementById('superzoom-content');
  if (!superzoomContent) {
    return; // Exit early if superzoom-content does not exist
  }

  var imageElement = superzoomContent.querySelector('img');
  var zoomUpButton = document.querySelector('[data-zoom-up]');
  var zoomDownButton = document.querySelector('[data-zoom-down]');

  if (!imageElement) {
    return; // Exit early if image element does not exist
  }

  if (imageElement.complete) {
    init();
  } else {
    imageElement.onload = init;
  }

  function init() {
    if (!imageElement) {
      return; // Safety check
    }

    // 确保图片以原始尺寸显示
    imageElement.style.width = imageElement.naturalWidth + 'px';
    imageElement.style.height = imageElement.naturalHeight + 'px';
    imageElement.style.maxWidth = 'none';
    imageElement.style.maxHeight = 'none';

    // 计算初始缩放比例，确保图片至少以原始分辨率显示
    var viewport = document.getElementById('superzoom-viewport');
    var initialScale = 1.0;
    if (viewport) {
      var viewportWidth = viewport.clientWidth || window.innerWidth;
      var viewportHeight = viewport.clientHeight || window.innerHeight;
      var imgWidth = imageElement.naturalWidth;
      var imgHeight = imageElement.naturalHeight;
      
      // 如果图片小于视口，以1:1显示；如果大于视口，以适合视口但尽可能大的比例显示（至少1:1）
      var scaleX = viewportWidth / imgWidth;
      var scaleY = viewportHeight / imgHeight;
      initialScale = Math.max(1.0, Math.min(scaleX, scaleY));
    }

    var wzoom = WZoom.create('#superzoom-content', {
        type: 'html',
        width: imageElement.naturalWidth,
        height: imageElement.naturalHeight,
        zoomOnClick: false,
        smoothTimeDrag: 0.1,
        minScale: initialScale,
        maxScale: 5,
        onGrab: function () {
            var viewport = document.getElementById('superzoom-viewport');
            if (viewport) {
              viewport.style.cursor = 'grabbing';
            }
        },
        onDrop: function () {
            var viewport = document.getElementById('superzoom-viewport');
            if (viewport) {
              viewport.style.cursor = 'grab';
            }
        },
    });
    
    // 初始化后设置缩放
    setTimeout(function() {
      if (wzoom && typeof wzoom.scale === 'function') {
        wzoom.scale(initialScale);
      } else if (wzoom && wzoom.setScale) {
        wzoom.setScale(initialScale);
      }
    }, 100);

    if (zoomUpButton) {
      zoomUpButton.addEventListener('click', function () {
          wzoom.zoomUp();
      });
    }

    if (zoomDownButton) {
      zoomDownButton.addEventListener('click', function () {
          wzoom.zoomDown();
      });
    }

    window.addEventListener('resize', function () {
        wzoom.prepare();
    });

  }
});
