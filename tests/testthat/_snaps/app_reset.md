# .appResetButton

    <div>
      <div class="form-group shiny-input-container" style="width: 90%;">
        <div class="pretty p-toggle p-default p-round p-fill">
          <input id="myid-resetButton" type="checkbox"/>
          <div class="state p-on p-danger">
            <label>
              <span>Cancel Application Reset</span>
            </label>
          </div>
          <div class="state p-off p-warning">
            <label>
              <span>Reset Application</span>
            </label>
          </div>
        </div>
      </div>
      <span class="invisible">
        <div class="form-group shiny-input-container">
          <div class="pretty p-toggle p-default">
            <input id="myid-resetPending" type="checkbox"/>
            <div class="state p-on p-success">
              <label>
                <span></span>
              </label>
            </div>
            <div class="state p-off p-danger">
              <label>
                <span></span>
              </label>
            </div>
          </div>
        </div>
      </span>
    </div>

